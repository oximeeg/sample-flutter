# example

# iOS build

## Archive

```
flutter clean && \
flutter build ipa \
  --release \
  --obfuscate \
  --split-debug-info=./build/split/ipa \
  --dart-define-from-file=dart_defines/prod.json \
  --no-codesign
```

## export

```
xcodebuild \
  -exportArchive \
  -archivePath ./build/ios/archive/Runner.xcarchive \
  -exportPath ./build/ios/ipa \
  -exportOptionsPlist ./secrets/export_options.plist \
  -allowProvisioningUpdates
```

# Android build

```
flutter clean && \
flutter build appbundle \
  --release \
  --obfuscate \
  --split-debug-info=./build/split/appbundle \
  --dart-define-from-file=dart_defines/prod.json \
  --build-number 1
```

# Web build

```
flutter build web --release
```

# Deploy a Flutter Web App to Vercel

- Build command: `flutter/bin/flutter pub get && flutter/bin/flutter pub run build_runner build --delete-conflicting-outputs && flutter/bin/flutter build web --release`
- Output directory: `build/web`
- Install command: `if cd flutter; then git pull && cd .. ; else git clone https://github.com/flutter/flutter.git --depth 1 -b stable; fi && ls && flutter/bin/flutter doctor && flutter/bin/flutter clean && flutter/bin/flutter config --enable-web`
