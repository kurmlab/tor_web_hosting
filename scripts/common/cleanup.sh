#!/bin/sh

# Clean the apt caches
sudo apt autoremove -y && \
sudo apt clean && \
sudo rm -rf /var/lib/apt/lists/*
