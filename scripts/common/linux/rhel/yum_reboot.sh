#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

echo "==> Update Package Lists For Available Upgrades"
yum update -y

echo "==> Performing Full Distribution Upgrade"
yum upgrade -y

echo "==> Performing Reboot"
/sbin/shutdown -r now
