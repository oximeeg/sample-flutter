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
