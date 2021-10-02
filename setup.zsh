#!/usr/bin/env zsh

asdf plugin add ruby
asdf plugin add direnv
asdf plugin add dart

asdf install

source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk env install

fvm install
fvm flutter pub get

BUNDLE_GEMFILE=ios/Gemfile bundle install
direnv allow .
