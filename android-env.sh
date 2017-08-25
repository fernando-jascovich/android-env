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
       android-env ./gradlew '

