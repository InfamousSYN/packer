#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

echo "==> Updating list of repositories"
yum -y update

echo "==> Installing open-vm-tools packages"
yum install -y open-vm-tools
