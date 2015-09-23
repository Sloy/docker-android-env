FROM ubuntu:15.10

## -- Java
# Install stuff
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

## -- Android
ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq libstdc++6:i386 zlib1g:i386 libncurses5:i386 --no-install-recommends && \
    apt-get clean

# Download and untar SDK
ENV ANDROID_SDK_URL http://dl.google.com/android/android-sdk_r24.3.1-linux.tgz
RUN curl -L "${ANDROID_SDK_URL}" | tar --no-same-owner -xz -C /usr/local
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_SDK /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

# Install Android SDK components
ENV ANDROID_SDK_COMPONENTS platform-tools,build-tools-23.0.1,build-tools-22.0.1,android-21,android-22,android-23,extra-android-m2repository,extra-google-m2repository
RUN echo y | android update sdk --no-ui --all --filter "${ANDROID_SDK_COMPONENTS}"

# Support Gradle
ENV TERM dumb
ENV JAVA_OPTS -Xms256m -Xmx512m

# Pre-install gradle for faster builds. You can use the local gradle installation or the wrapper
# Based on niaquinto/gradle (https://github.com/niaquinto/docker-gradle)
ENV GRADLE_VERSION 2.6
ENV GRADLE_HASH 88a116b028e4749c9d77e514904755a9
WORKDIR /usr/bin
RUN wget "https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" && \
    echo "${GRADLE_HASH} gradle-${GRADLE_VERSION}-bin.zip" > gradle-${GRADLE_VERSION}-bin.zip.md5 && \
    md5sum -c gradle-${GRADLE_VERSION}-bin.zip.md5 && \
    unzip "gradle-${GRADLE_VERSION}-bin.zip" && \
    ln -s "gradle-${GRADLE_VERSION}" gradle && \
    rm "gradle-${GRADLE_VERSION}-bin.zip"

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin
