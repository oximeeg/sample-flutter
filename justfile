# To use this file, install Just: brew install just
# https://github.com/casey/just

default: init

init:
  git clean -ffdx

update:
  just init
  rm -rf sample plugin
  mise install
  just app
  just plugin

app:
  flutter create \
    --org com.oximeeg \
    --project-name sample \
    sample

plugin:
  flutter create \
    --org com.oximeeg \
    --template=plugin \
    --platforms=android,ios \
    -a kotlin \
    -i swift \
    plugin