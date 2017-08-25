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
export ANDROID_HOME ~/.android/sdk
```

### Host emulator creation
```
sdkmanager --update emulator
avdmanager create avd -c 512M \
	   -k "system-images;android-26;google_apis;x86" \
	   -n android-26 \
	   -b google_apis/x86 \
	   -d "Nexus 5"
echo "hw.gpu.enabled=yes" >> $ANDROID_SDK_ROOT/../avd/android-26.avd/config.ini
echo "skin.dynamic=no" >> $ANDROID_SDK_ROOT/../avd/android-26.avd/config.ini
echo "skin.name=1080x1920" >> $ANDROID_SDK_ROOT/../avd/android-26.avd/config.ini
echo "skin.path=1080x1920" >> $ANDROID_SDK_ROOT/../avd/android-26.avd/config.ini
```

### Notes
Please note that for local m2 repository cache, the `uploadArchives` gradle tasks must point to the docker volume configured path (i.e.: `file:///root/.m2/repository`)

After `source` you can do `android-env-run tasks` or `android-env-run assembleRelease`
