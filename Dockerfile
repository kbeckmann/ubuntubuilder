FROM ubuntu

WORKDIR /opt

ENV DEBIAN_FRONTEND=noninteractive

# Downloading from the original mirrir is very slow, use a faster mirror.
# https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2?revision=ca0cbf9c-9de2-491c-ac48-898b5bbc0443&la=en&hash=68760A8AE66026BCF99F05AC017A6A50C6FD832A

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        build-essential debhelper devscripts wget curl sudo vim git \
        cmake ninja-build \
        python3 python-is-python3 python3-virtualenv python3-pip \
        libusb-1.0-0 \
        && \
    curl -L --http1.1 -o toolchain.tar.bz2 'https://allg.one/omlA' && \
    tar xf toolchain.tar.bz2 && \
    rm -f toolchain.tar.bz2 && \
    useradd -m docker && echo "docker:docker" | chpasswd && \
    chown docker:docker /opt && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENV GCC_PATH=/opt/gcc-arm-none-eabi-10-2020-q4-major/bin

USER docker

# Ready to build and install aur packages on a clean machine
CMD /bin/bash
