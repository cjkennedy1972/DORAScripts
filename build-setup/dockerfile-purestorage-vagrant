FROM ubuntu:16.04
MAINTAINER Ashutosh Kumar akumar@purestorage.com
RUN sed -i~orig -e 's/# deb-src/deb-src/' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install ruby-dev libxml2-dev libxslt-dev pkg-config make clang wget virtualbox rsync ssh -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN wget https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.deb
RUN dpkg -i vagrant_2.1.2_x86_64.deb
RUN rm vagrant_2.1.2_x86_64.deb
RUN vagrant plugin install vagrant-vsphere