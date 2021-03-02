#!/bin/bash -eux

DISK_USAGE_BEFORE_CLEANUP=$(df -h)

echo "==> Cleanup APT cache"
export DEBIAN_FRONTEND=noninteractive
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

echo "==> Removing Bash history"
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

echo "==> Zero out the free space to save space in the final image"
dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed"
rm -f /EMPTY

# Make sure we wait until all the data is written to disk, otherwise
# Packer might quite too early
sync

echo "==> Disk usage before cleanup"
echo ${DISK_USAGE_BEFORE_CLEANUP}

echo "==> Disk usage after cleanup"
df -h

sync;
