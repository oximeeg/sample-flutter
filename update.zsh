#!/usr/bin/env zsh -x

accent='32m'

__println() {
  printf "\e[1;${accent}%s\e[0m\n" "[*] $@"
}

__println "update flutter"
flutter_version=`fvm releases | grep stable | tail -n 1`
flutter_version=`echo $flutter_version | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g" | awk '{print $4}'`
sed -i '' -E "s/\"flutter\": \"[^\"]+\"/\"flutter\": \"$flutter_version\"/" .fvmrc
__println "$flutter_version"
fvm global $flutter_version
