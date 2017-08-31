FROM ubuntu:16.04

ENV ANDROID_SDK_TOOLS_VERSION 3859397

RUN apt-get update -qq
RUN apt-get install -yqq wget unzip

RUN apt-get install -yqq openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ENV K_VER 1.1.4
ENV K_COMPILER_URL https://github.com/JetBrains/kotlin/releases/download/v${K_VER}/kotlin-compiler-${K_VER}.zip
RUN wget $K_COMPILER_URL -O /tmp/a.zip
RUN unzip /tmp/a.zip -d /opt
RUN rm /tmp/a.zip
ENV PATH $PATH:/opt/kotlinc/bin

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip -O /tmp/android-cli.zip
RUN mkdir /opt/android-sdk && unzip /tmp/android-cli.zip -d /opt/android-sdk
RUN rm /tmp/android-cli.zip
ENV PATH $PATH:/opt/android-sdk/tools
ENV PATH $PATH:/opt/android-sdk/tools/bin
ENV PATH $PATH:/opt/android-sdk/platform-tools
ENV ANDROID_HOME /opt/android-sdk

RUN mkdir /root/.android && \
    touch /root/.android/repositories.cfg

VOLUME /root/.m2

RUN mkdir /code
WORKDIR /code
