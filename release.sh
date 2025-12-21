#!/usr/bin/env bash
#
# Prepares the catalogs for release.
#
# Usage: ./release.sh [version]
#        ./release.sh --snapshot
#
# If version is not provided, uses current date (YYYY.MM.DD format).
# Use --snapshot to publish a SNAPSHOT version without git commits/tags.

set -euo pipefail

# The script could be run from any directory.
cd "$(dirname "$0")"

# Configure the script
changelog="CHANGELOG.md"
github_repository_url="https://github.com/lscythe/gradle-version-catalog"

#region Utils
function get_last_version() {
  git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' || echo "0.0.0"
}

function diff_link() {
  echo -n "$github_repository_url/compare/${1}...${2}"
}
#endregion

# Handle --snapshot option
if [[ "${1:-}" == "--snapshot" ]]; then
  version="$(date +%Y.%m.%d)-SNAPSHOT"
  echo "🔧 Publishing SNAPSHOT version: $version"
  echo
  VERSION="$version" ./gradlew publishAllPublicationsToMavenCentralRepository
  echo
  echo "🎉 SNAPSHOT published: $version"
  exit 0
fi

# 0. Fetch remote changes
echo "⏳ Updating local repository..."
git fetch --quiet --tags origin
echo "✅ Repository updated."
echo

# 1. Calculate version values
last_version=$(get_last_version)
if [[ -n "${1:-}" ]]; then
  version="$1"
else
  version=$(date "+%Y.%m.%d")
fi

# Handle same-day releases
if [[ "$last_version" == "$version" ]]; then
  patch=1
  while git rev-parse "v$version.$patch" >/dev/null 2>&1; do
    ((patch++))
  done
  version="$version.$patch"
fi

echo "🚀 Release $last_version → $version"
echo

# 2. Update CHANGELOG.md
if [[ -f "$changelog" ]]; then
  today=$(date '+%Y-%m-%d')
  
  # Create temp file with updated content
  awk -v ver="$version" -v date="$today" '
    /^## \[Unreleased\]/ {
      print "## [Unreleased]"
      print ""
      print "## [" ver "] - " date
      next
    }
    { print }
  ' "$changelog" > "$changelog.tmp"
  mv "$changelog.tmp" "$changelog"
  echo "✅ Updated CHANGELOG.md header"
  
  # Update diff links
  if grep -q "^\[unreleased\]:" "$changelog"; then
    sed -i".bak" "s|\[unreleased\]:.*|\[unreleased\]: $(diff_link "v$version" "main")|" "$changelog"
    
    # Add version link if not exists
    if ! grep -q "^\[$version\]:" "$changelog"; then
      echo "[$version]: $(diff_link "v$last_version" "v$version")" >> "$changelog"
    fi
    rm -f "$changelog.bak"
    echo "✅ Updated diff links in CHANGELOG.md"
  fi
fi

# 3. Show changes
echo
echo "📋 Changes to be committed:"
git diff --stat

# 4. Ask for confirmation
echo
echo "Do you want to commit the changes and create release tag v$version?"
echo "The tag push will trigger the publish workflow on CI."
read -p "Enter 'yes' to continue: " -r input
if [[ "$input" != "yes" ]]; then
  echo "👌 Aborted. Changes not committed."
  git checkout -- "$changelog" 2>/dev/null || true
  exit 0
fi

# 5. Commit and tag
echo
echo "⏳ Creating release..."
git add -A
git commit --quiet --message "release: v$version"
git tag "v$version" -m "Release v$version"
echo "✅ Created tag v$version"

# 6. Push
echo "⏳ Pushing to remote..."
git push --quiet origin HEAD
git push --quiet origin "v$version"
echo
echo "🎉 DONE!"
echo
echo "📦 Release will be published automatically via GitHub Actions."
echo "🔗 View release: $github_repository_url/releases/tag/v$version"
