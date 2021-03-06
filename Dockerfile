FROM ubuntu

WORKDIR /opt

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        build-essential debhelper devscripts wget curl sudo vim git \
        cmake ninja-build \
        python3 python-is-python3 python3-virtualenv python3-pip \
        libusb-1.0-0 \
        && \
    useradd -m docker && echo "docker:docker" | chpasswd && \
    chown docker:docker /opt && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER docker

# Ready to build and install aur packages on a clean machine
CMD /bin/bash
