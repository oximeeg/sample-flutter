#!/usr/bin/env zsh -x

accent='32m'
warn='33m'

__println() {
  printf "\e[1;${accent}%s\e[0m\n" "[*] $@"
}

__print_warn() {
  printf "\e[1;${warn}%s\e[0m\n" "$@"
}

__println "update flutter"
version=`fvm releases | grep stable | awk '{print $5}'`
sed -i '' -E "s/\"flutterSdkVersion\": \"[^\"]+\"/\"flutterSdkVersion\": \"${version}\"/" .fvm/fvm_config.json

__println "fvm install"
dart_version=`fvm install | grep Dart | awk '{print $4}'`

cat .tool-versions | while read line; do
  tool=`echo $line | awk '{print $1}'`
  version=latest
  if [ "$tool" = "java" ]; then
    version=`asdf list all java | grep corretto-17 | tail -n 1`
  elif [ "$tool" = "gradle" ]; then
    version='7.5'
  elif [ "$tool" = "dart" ]; then
    version=$dart_version
  fi

  __println "asdf install $tool $version"
  asdf install $tool $version

  __println "asdf local $tool $version"
  asdf local $tool $version
done

__println "asdf install"
asdf install

__println "update dart"
version=`cat .tool-versions | grep dart | awk '{print $2}'`
sed -i '' -E "s/sdk: .+ # dart/sdk: $version # dart/" pubspec.yaml

__println "update package"
fvm flutter pub upgrade --major-versions
sed -i '' "s/: ^/: /g" pubspec.yaml
rm -rf pubspec.lock

__println "update cocoapods"
version=`curl -s https://rubygems.org/api/v1/gems/cocoapods.json | grep -o '"version":"[^"]*' | grep -o '[^"]*$'`
sed -i '' -E "s/'cocoapods', '[^']+'/'cocoapods', '$version'/" $BUNDLE_GEMFILE

__println "remove vendor Gemfile.lock"
find . -maxdepth 2 -type d -name vendor -prune -exec rm -rf {} +
rm -rf ${BUNDLE_GEMFILE}.lock

__println "bundle install"
bundle install

__println "direnv reload"
direnv reload

__println "pod: `direnv exec . which pod` version:`direnv exec . pod --version`"

__println "dart pub outdated"
fvm dart pub outdated
