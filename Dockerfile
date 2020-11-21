FROM ubuntu

WORKDIR /opt

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        build-essential wget curl sudo vim git \
        python3 python-is-python3 python3-virtualenv python3-pip \
    && \
    useradd -m docker && echo "docker:docker" | chpasswd && \
    chown docker:docker /opt && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER docker

# Ready to build and install aur packages on a clean machine
CMD /bin/bash
