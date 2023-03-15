#!/usr/bin/env zsh

asdf plugin add ruby
asdf plugin add direnv
asdf plugin add dart

asdf install

source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk env install

fvm install
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs

BUNDLE_GEMFILE=Gemfile bundle install
direnv allow .
