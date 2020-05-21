# My Changed

- Support `Android` platform.  see `android_api_21` branch.

## Usage

```bash

# uncompress the jniLibs to the `host_swift_project/.build` directory
# `host_swift_project` is the project that depends on `skia_swift_cross_platform`

tar -zxvf jniLibs.7z -C host_swift_project/.build
```

```swift
let package = Package(
    name: packageName,
    products: addGenerated([
    ]),
    dependencies: [
        .package(url: "https://github.com/Guang1234567/Skia_Swift_CrossPlatform.git", .branch("android_api_21"))
    ],

    targets: addGenerated([
        .target(name: packageName,
                dependencies: [
                    "SkiaSwift"
                ]),
    ])
)
```

## Build skia.a for Android

```bash
bin/gn gen out/Release/android/arm64-v8a --args='ndk="/tmp/ndk-bundle-16" target_cpu="arm64" extra_cflags_cc=["-frtti", "-Wno-shadow-field"] ndk_api=21 target_os="android" is_debug=false skia_use_system_expat=false skia_use_system_libjpeg_turbo=true skia_use_system_libpng=false skia_use_system_libwebp=true skia_use_system_zlib=true skia_use_system_icu=true skia_use_icu=false skia_use_libjpeg_turbo=false skia_use_system_freetype2=false skia_use_system_jsoncpp=true skia_use_libwebp=false skia_use_system_lua=false skia_use_icu=false skia_use_egl=true skia_use_angle=false skia_enable_pdf=false skia_enable_skottie=false skia_enable_effects=true skia_enable_vulkan_debug_layers=false skia_use_dng_sdk=true skia_use_lua=false skia_use_metal=false skia_enable_flutter_defines=true'
```

https://www.skiatest.org/user/build#android

## Example

[Swift_Android_Skia_EGl_Example](https://github.com/Guang1234567/Swift_Android_Glue/blob/master/Examples/Android/native-activity/app/src/main/swift/Sources/native-activity/native-activity.swift)

=============================

# SkiaSwift

Swift wrapper for [SkiaSharp](https://github.com/mono/SkiaSharp)'s C API

See:
* [SkiaSharp's C API](https://github.com/mono/skia), which is a fork of [Skia](https://skia.org),
  to add more features to the original Skia's C API
* [CSkiaSwift](https://github.com/swiftfn/SkiaSwift)

This project uses [Swift Package Manager](https://swift.org/package-manager/):
* https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md
* https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md
* https://clang.llvm.org/docs/Modules.html

## Build SkiaSharp's Skia fork

Download [SkiaSharp's Skia fork](https://github.com/mono/skia),
then see these doc to build:
* https://skia.org/user/download
* https://skia.org/user/build
* https://stackoverflow.com/questions/50228652/how-to-compile-skia-on-windows
* https://github.com/flutter/engine/blob/master/tools/gn

Build static libraries:

```sh
bin/gn gen out --args="is_debug=false is_official_build=true \
skia_use_system_expat=false skia_use_system_libjpeg_turbo=false \
skia_use_system_libpng=false skia_use_system_libwebp=false \
skia_use_system_zlib=false skia_use_system_icu=false \
skia_use_system_harfbuzz=false"

ninja -C out
```

## Build CSkiaSwift

Create symlinks to the built Skia above
(only `include/c` and `out` directories are used):

```sh
cd Sources/CSkia/include
ln -s /path/to/skia/include/c

cd Sources/CSkia
ln -s /path/to/skia/out
```

Build:

```sh
swift build
swift build -c release
```

Run:

```sh
swift run Demo
.build/debug/Demo
.build/release/Demo
```

## Generate doc

Install [jazzy](https://github.com/realm/jazzy), then run:

```sh
jazzy --module SkiaSwift
```
