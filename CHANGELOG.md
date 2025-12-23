# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2025.12.24] - 2025-12-24


### Added

- `versions-androidx`: Added `com.android.tools.build:gradle` and `com.android.tools.build:gradle-api`
- `versions-kotlinx`: Added `org.jetbrains.kotlin:kotlin-gradle-plugin` and `org.jetbrains.kotlinx:binary-compatibility-validator`
- `versions-compose-multiplatform`: Added `org.jetbrains.kotlin:compose-compiler-gradle-plugin`
- `versions-utils`: Added `com.dropbox.dependency-guard`, `org.jetbrains.dokka`, `com.diffplug.spotless` and `com.lemonappdev:konsist`

### Changed
- `versions-compose-jetpack`: Move compiler to `versions-compose-multiplatform`

## [2025.12.21] - 2025-12-21

## [2025.12.21-SNAPSHOT] - 2025-12-21

### Added

- Initial release of Lscythe Version Catalogs
- `versions-androidx` - AndroidX libraries including Core, Activity, Lifecycle, Navigation, Room, Hilt, Paging, Work, Camera, and Media3
- `versions-kotlinx` - KotlinX libraries including Coroutines, Serialization, DateTime, Collections Immutable, AtomicFU, IO, and Koin DI
- `versions-compose-jetpack` - Jetpack Compose libraries including BOM, UI, Foundation, Material3, Accompanist, and Coil
- `versions-compose-multiplatform` - JetBrains Compose Multiplatform libraries including UI, Material3, Navigation, Voyager, and Coil3
- `versions-utils` - Utility libraries including Ktor, OkHttp, log4k, SQLDelight, Exposed, Arrow, and testing frameworks
- Pre-configured bundles for common dependency combinations
- GitHub Actions workflows for CI, security scanning, and automated publishing
- Renovate configuration for automated dependency updates

- [unreleased]: https://github.com/lscythe/gradle-version-catalog/compare/v2025.12.21-SNAPSHOT...main
