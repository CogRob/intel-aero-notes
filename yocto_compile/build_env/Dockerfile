FROM ubuntu:xenial

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --yes \
      gawk wget git-core diffstat unzip texinfo gcc-multilib \
      build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
      xz-utils debianutils iputils-ping && \
  rm -rf /var/lib/apt/lists/*

RUN \
  wget http://commondatastorage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo && \
  chmod a+x /usr/local/bin/repo

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales && rm -rf /var/lib/apt/lists/*
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
