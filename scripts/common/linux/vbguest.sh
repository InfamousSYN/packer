#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

echo "==> Installing VirtualBox Guest Additions"
apt-get --assume-yes install virtualbox-guest-x11 --fix-missing