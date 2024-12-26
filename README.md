# sample-flutter

```
fvm releases
```

```
fvm install && \
yes | fvm use && \
rm -rf sample plugin
```

```
fvm flutter create \
  --org com.oximeeg \
  --project-name sample \
  sample
```

```
fvm flutter create \
  --org com.oximeeg \
  --template=plugin \
  --platforms=android,ios \
  -a kotlin \
  -i swift \
  plugin
```