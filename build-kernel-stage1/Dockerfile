FROM ubuntu:16.04
MAINTAINER Ashutosh Kumar akumar@purestorage.com
USER root
RUN sed -i~orig -e 's/# deb-src/deb-src/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install dpkg-dev git -y
RUN apt-get source linux-image-4.4.0-130-generic
RUN apt-get build-dep linux-image-4.4.0-130-generic -y

WORKDIR /data/ubuntu-xenial/