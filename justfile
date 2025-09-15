# To use this file, install Just: brew install just
# https://github.com/casey/just

default: init

init:
  git clean -ffdx

update:
  zsh update.zsh
  rm -rf sample plugin
  fvm install | fvm use
  just app
  just plugin

app:
  fvm flutter create \
    --org com.oximeeg \
    --project-name sample \
    sample

plugin:
  fvm flutter create \
    --org com.oximeeg \
    --template=plugin \
    --platforms=android,ios \
    -a kotlin \
    -i swift \
    plugin