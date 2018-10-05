#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

echo "==> Update Package Lists For Available Upgrades"
apt --assume-yes update

echo "==> Performing Full Distribution Upgrade"
apt --assume-yes full-upgrade