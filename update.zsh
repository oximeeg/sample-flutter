#!/usr/bin/env zsh -x

accent='32m'

__println() {
  printf "\e[1;${accent}%s\e[0m\n" "[*] $@"
}

__println "update flutter"
flutter_version=3.41.8
sed -i '' -E "s/\"flutter\": \"[^\"]+\"/\"flutter\": \"$flutter_version\"/" .fvmrc
__println "$flutter_version"
yes | fvm global $flutter_version
