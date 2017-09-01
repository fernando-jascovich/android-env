### For txt packages file instalation
# docker run -it \
#        -v $PWD:/tmp
#        -v android-env-packages:/opt/android-sdk \
#        android-env sdkmanager --package-file=/tmp/android-packages.txt

alias android-env-sdkmanager='docker run -it \
       -v android-env-packages:/opt/android-sdk \
       android-env sdkmanager'

alias android-env-run='docker run \
       -v $PWD:/code \
       -v android-env-gradle:/root/.gradle \
       -v android-env-m2:/root/.m2 \
       -v android-env-packages:/opt/android-sdk \
       --net host \
       android-env '

alias android-env-run-it='docker run -it \
       -v $PWD:/code \
       -v android-env-gradle:/root/.gradle \
       -v android-env-m2:/root/.m2 \
       -v android-env-packages:/opt/android-sdk \
       --net host \
       android-env '

alias android-env-gradle='docker run \
       -v $PWD:/code \
       -v android-env-gradle:/root/.gradle \
       -v android-env-m2:/root/.m2 \
       -v android-env-packages:/opt/android-sdk \
       --net host \
       android-env ./gradlew '

alias android-env-gradle-daemon='docker run -it -d \
       -v $PWD:/code \
       -v android-env-gradle:/root/.gradle \
       -v android-env-m2:/root/.m2 \
       -v android-env-packages:/opt/android-sdk \
       --net host \
       android-env bash -c "./gradlew tasks && tail -f /dev/null"'

alias android-emulator='~/.android/sdk/tools/emulator'

function android-create-emulator {
    set -e
    if ! [ -n "${ANDROID_SDK_ROOT+1}" ]; then
	echo "\$ANDROID_SDK_ROOT is not defined."
	exit 1
    fi
    echo "Creating device with android-$1 called: $2"
    echo "Verifying required packages..."
    sdkmanager emulator
    sdkmanager platform-tools
    sdkmanager "platforms;android-$1"
    sdkmanager "system-images;android-$1;google_apis;x86"
    export PATH=$PATH:~/.android/sdk/platform-tools
    echo "Creating avd..."
    avdmanager create avd -c 512M \
    	       -k "system-images;android-$1;google_apis;x86" \
    	       -n $2 \
    	       -b google_apis/x86 \
    	       -d "Nexus 5" \
    	       --force
    echo "Setting up device..."
    echo "hw.gpu.enabled=yes" >> $ANDROID_SDK_ROOT/../avd/$2.avd/config.ini
    echo "skin.dynamic=no" >> $ANDROID_SDK_ROOT/../avd/$2.avd/config.ini
    echo "skin.name=1080x1920" >> $ANDROID_SDK_ROOT/../avd/$2.avd/config.ini
    echo "skin.path=1080x1920" >> $ANDROID_SDK_ROOT/../avd/$2.avd/config.ini
    $ANDROID_SDK_ROOT/tools/mksdcard -l SDCARD 512M $ANDROID_SDK_ROOT/../avd/$2.avd/sdcard.img
}
