#!/bin/bash -eux

echo "==> Updating list of repositories"
apt-get -y update

echo "==> Installing open-vm-tools packages"
apt --assume-yes install open-vm-tools