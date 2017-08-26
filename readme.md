# Dockerized android environment

### Docker container
```
docker build -t android-env .
```

### Bash aliases
```
source android-env.sh
```

### Docker volumes
```
docker volume create android-env-gradle
docker volume create android-env-packages
docker volume create android-env-m2
```

### Host avd creation
```
mkdir -p ~/.android/sdk && cd ~/.android/sdk
curl -O https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
unzip sdk-tools-linux-3859397.zip
export PATH=$PATH:~/.android/sdk/tools
export PATH=$PATH:~/.android/sdk/tools/bin
export ANDROID_SDK_ROOT ~/.android/sdk

# Bash aliases step is required for this
android-create-emulator 26 phone-oreo
```

### Notes
Please note that for local m2 repository cache, the `uploadArchives` gradle tasks must point to the docker volume configured path (i.e.: `file:///root/.m2/repository`)

After `source` you can do `android-env-run tasks` or `android-env-run assembleRelease`
