FROM ubuntu:16.04
MAINTAINER Abbhijit Zanak

RUN apt-get update -y \
  && apt-get install -y pkg-config zip g++ zlib1g-dev unzip python \
  && apt-get install -y wget \
  && apt-get install -y curl \
  && wget https://github.com/bazelbuild/bazel/releases/download/0.16.1/bazel-0.16.1-installer-linux-x86_64.sh \
  && chmod +x bazel-0.16.1-installer-linux-x86_64.sh \
  && ./bazel-0.16.1-installer-linux-x86_64.sh --user \
  && export PATH="$PATH:$HOME/bin" \
  && apt-get install openjdk-8-jdk -y \
  && apt-get install software-properties-common -y \
  && add-apt-repository ppa:webupd8team/java \
  && echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && curl https://bazel.build/bazel-release.pub.gpg | apt-key add - \
  && apt-get update -y && apt-get install bazel -y \
  && apt-get upgrade bazel -y \
  && apt-get install python-numpy python-dev python-pip python-wheel -y \
  && pip install --upgrade pip enum34 \
