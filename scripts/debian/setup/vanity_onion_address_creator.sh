#!/bin/bash

# Install Pre-Reqs
sudo apt-get install -y \
                     git \
                     gcc \
                     libc6-dev \
                     libsodium-dev \
                     make \
                     autoconf

# Download Git Repo

cd /opt
sudo git clone https://github.com/cathugger/mkp224o.git
cd mkp224o

# Build
sudo ./autogen.sh && \
sudo ./configure && \
sudo make

