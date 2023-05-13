#!/usr/bin/env zsh

asdf plugin add dart
asdf plugin add direnv
asdf plugin add gradle
asdf plugin add java
asdf plugin add ruby

asdf install

fvm install
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs

BUNDLE_GEMFILE=Gemfile bundle install
direnv allow .
