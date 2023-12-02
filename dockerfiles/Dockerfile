# Use the official ubuntu base image from Docker Hub
# This Dockerfile is used to build an headles vnc image based on Ubuntu:latest
FROM debian:stable-slim
LABEL maintainer="sys41x4@gmail.com"
MAINTAINER Arijit Bhowmick "sys41x4@gmail.com"
ENV REFRESHED_AT 2023-10-14

ENV TZ=Asia/Kolkata \
    LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    LC_ALL='en_US.UTF-8' \
    DEBIAN_FRONTEND=noninteractive


RUN mkdir -p /scripts /sites

COPY scripts/ /scripts

# Install required packages
RUN apt-get update && apt-get install -y \
            curl \
            wget \
            ca-certificates \
            gpg \
	        gpg-agent \
            libcap2-bin \
            git

                    
## Set Keyboard type to US
RUN echo "keyboard-configuration keyboard-configuration/layout select us" | debconf-set-selections

# Add additional repositories
RUN /scripts/debian/setup/repositories.sh

# Install base packages
RUN /scripts/debian/setup/base_pkgs.sh

# Create Dir Structure
RUN /scripts/common/setup/create_dir_structure.sh

# Create user
RUN /scripts/common/user_setup.sh tor-user

# Install tor service
RUN /scripts/debian/setup/tor.sh

COPY scripts/common/start-tor.sh /usr/local/bin
RUN chmod 0755 /usr/local/bin/start-tor.sh

# Copy get-bridge-line
COPY scripts/common/get-bridge-line /usr/local/bin
RUN chmod 0755 /usr/local/bin/get-bridge-line

RUN cp scripts/entrypoint.sh /entrypoint.sh
RUN chmod 0755 /entrypoint.sh


# Cleanup Tasks
RUN /scripts/common/cleanup.sh

RUN mkdir -p /etc/tor && chown tor-user:tor-user /etc/tor
RUN mkdir -p /var/lib/tor && chown tor-user:tor-user /var/lib/tor
RUN mkdir -p /var/log/tor && chown tor-user:tor-user /var/log/tor
RUN chown tor-user:tor-user /sites
RUN chown tor-user:tor-user /scripts



USER tor-user

# Start entrypoint in the foreground
ENTRYPOINT "/entrypoint.sh"