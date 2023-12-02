#!/bin/bash

# Create Sources.list for tor installation
# Get the distributor ID using lsb_release
DISTRIB_ID=$(lsb_release -i | cut -f2)

if [ "$DISTRIB_ID" = "Debian" ]; then
  # If the distributor ID is "Debian," set DISTRIBUTION from lsb_release -c
  DISTRIBUTION=$(lsb_release -c | cut -f2)
else
  # Otherwise, set DISTRIBUTION from /etc/debian_version
  DISTRIBUTION=$(cat /etc/debian_version | cut -d '/' -f 1)
fi

# Create or overwrite the /etc/apt/sources.list.d/tor.list file
echo "deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org $DISTRIBUTION main" | sudo tee /etc/apt/sources.list.d/tor.list
echo "deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org $DISTRIBUTION main" | sudo tee -a /etc/apt/sources.list.d/tor.list

wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmour | sudo tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null

sudo apt-get update && \
sudo apt-get install -y tor \
                   tor-geoipdb \
                   deb.torproject.org-keyring \
                   obfs4proxy \
                   --no-install-recommends
setcap cap_net_bind_service=+ep /usr/bin/obfs4proxy # buildkit

sudo mkdir -p /etc/tor && chown tor-user:tor-user /etc/tor # buildkit
sudo mkdir -p /var/log/tor && chown tor-user:tor-user /var/log/tor # buildkit
sudo mkdir -p /sites && chown tor-user:tor-user /sites # buildkit

# sudo cp /scripts/start-tor.sh /usr/local/bin
