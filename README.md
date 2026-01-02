# Lscythe Version Catalogs

[![Main CI](https://github.com/lscythe/gradle-version-catalogs/actions/workflows/ci.yml/badge.svg)](https://github.com/lscythe/gradle-version-catalogs/actions/workflows/ci.yml)
[![Security](https://github.com/lscythe/gradle-version-catalogs/actions/workflows/security.yml/badge.svg)](https://github.com/lscythe/gradle-version-catalogs/actions/workflows/security.yml)
[![Maven Central Version](https://img.shields.io/maven-central/v/dev.lscythe.tool/versions-androidx)](https://central.sonatype.com/search?q=g:dev.lscythe.tool)
[![Kotlin](https://img.shields.io/badge/Kotlin-2.3.0-blue.svg)](https://kotlinlang.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Curated Gradle version catalogs for Kotlin projects. Provides centralized, consistent dependency management across multiple projects with pre-configured bundles for common use cases.

## Features

- Centralized dependency versions across projects
- Pre-configured bundles for common dependency combinations
- Automated version updates via Dependabot and version-catalog-update plugin
- Separate catalogs for different library groups
- Compatible with Gradle 7.6+

## Available Catalogs

| Catalog | Description | Key Libraries |
|---------|-------------|---------------|
| `versions-androidx` | Android Jetpack libraries | Core, Activity, Lifecycle, Navigation, Room, Hilt, Paging, Work, Camera, Media3 |
| `versions-kotlinx` | Official KotlinX libraries | Coroutines, Serialization, DateTime, Collections Immutable, AtomicFU, IO, Koin |
| `versions-compose-jetpack` | Android Jetpack Compose | BOM, UI, Foundation, Animation, Material3, Accompanist, Coil |
| `versions-compose-multiplatform` | JetBrains Compose Multiplatform | Runtime, UI, Foundation, Material3, Navigation, Coil3 |
| `versions-utils` | Common utility libraries | Ktor, OkHttp, log4k, SQLDelight, Exposed, Arrow, JUnit5, MockK, Kotest |

## Installation

Add the catalogs to your project's `settings.gradle.kts`:

```kotlin
dependencyResolutionManagement {
    repositories {
        mavenCentral()
        google()
    }
    versionCatalogs {
        create("androidx") { 
            from("dev.lscythe.tool:versions-androidx:<version>") 
        }
        create("kotlinx") { 
            from("dev.lscythe.tool:versions-kotlinx:<version>") 
        }
        create("compose") { 
            from("dev.lscythe.tool:versions-compose-jetpack:<version>") 
        }
        create("utils") { 
            from("dev.lscythe.tool:versions-utils:<version>") 
        }
    }
}
```

## Usage

### Single Dependencies

```kotlin
dependencies {
    implementation(androidx.core)
    implementation(androidx.activity.compose)
    implementation(kotlinx.coroutines.core)
    implementation(kotlinx.serialization.json)
    implementation(utils.ktor.client.core)
}
```

### Using Bundles

Bundles provide pre-configured groups of related dependencies:

```kotlin
dependencies {
    // AndroidX Lifecycle with Compose integration
    implementation(androidx.bundles.lifecycle.compose)
    
    // Compose core setup
    implementation(platform(compose.bom))
    implementation(compose.bundles.core)
    implementation(compose.bundles.material3)
    
    // Koin for dependency injection
    implementation(kotlinx.bundles.koin.compose)
    
    // Ktor client for Android
    implementation(utils.bundles.ktor.client.android)
    
    // Testing
    testImplementation(utils.bundles.testing.jvm)
}
```

### Available Bundles

**versions-androidx:**
- `lifecycle-compose` - Lifecycle runtime and ViewModel with Compose
- `room` - Room runtime and KTX
- `camera` - CameraX components
- `testing-unit` - Unit testing dependencies
- `testing-ui` - UI testing dependencies

**versions-kotlinx:**
- `coroutines-android` - Coroutines core and Android dispatcher
- `coroutines-jvm` - Coroutines for JVM
- `serialization` - Serialization core and JSON
- `koin-android` - Koin for Android
- `koin-compose` - Koin for Compose
- `testing` - Coroutines test and Koin test

**versions-compose-jetpack:**
- `core` - Runtime, Foundation, UI, Graphics, Tooling Preview
- `material3` - Material3 and Icons
- `material3-adaptive` - Adaptive layouts
- `testing` - Compose UI testing
- `tooling` - Compose tooling
- `coil` - Coil image loading

**versions-compose-multiplatform:**
- `core` - Runtime, Foundation, UI, Graphics, Tooling Preview
- `material3` - Material3 and Icons
- `lifecycle` - ViewModel and Runtime
- `coil` - Coil3 image loading

**versions-utils:**
- `ktor-client-android` - Ktor client for Android
- `ktor-client-ios` - Ktor client for iOS
- `ktor-client-jvm` - Ktor client for JVM
- `ktor-server` - Ktor server with Netty
- `okhttp` - OkHttp with logging
- `logging-multiplatform` - log4k
- `logging-jvm` - SLF4J and Logback
- `testing-jvm` - JUnit5, MockK, Turbine
- `testing-android` - JUnit5, MockK Android, Turbine
- `kotest` - Kotest runner and assertions
- `sqldelight-common` - SQLDelight runtime and coroutines
- `exposed` - Exposed core, DAO, JDBC
- `arrow` - Arrow core and FX

### Using Plugins

```kotlin
plugins {
    alias(androidx.plugins.hilt)
    alias(androidx.plugins.room)
    alias(kotlinx.plugins.serialization)
    alias(compose.plugins.compiler)
    alias(utils.plugins.sqldelight)
}
```

## Development

### Build

```bash
./gradlew build
```

### Publish to Local Maven Repository

```bash
./gradlew publishToMavenLocal
```

### Check for Dependency Updates

```bash
./gradlew versionCatalogUpdate
```

## Versioning

Published versions match git tags. Creating a tag `v1.0.0` publishes version `1.0.0`.

## Contributing

Contributions are welcome. Please open an issue or pull request.

## License

[MIT License](LICENSE)
