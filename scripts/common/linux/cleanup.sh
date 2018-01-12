#!/bin/sh -eux

# Remove apt sources
apt -y autoremove --purge
apt -y clean
apt -y autoclean

# Clear user's bash history
history -c

# Zero out hard drive for improved storage
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY