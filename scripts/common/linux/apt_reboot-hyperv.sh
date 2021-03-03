#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

echo "==> Update Package Lists For Available Upgrades"
apt --assume-yes update
#fix plymouth error by not updating automatically
#echo plymouth hold | dpkg --set-selections
#echo plymouth-label hold | dpkg --set-selections
echo "==> Performing Full Distribution Upgrade"
yes "N" | apt --assume-yes full-upgrade
#echo plymouth install | dpkg --set-selections
#echo plymouth-label install | dpkg --set-selections

