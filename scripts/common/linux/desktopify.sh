#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

echo "==> Switch from server to desktop distribution"
apt-get -y install ubuntu-gnome-desktop