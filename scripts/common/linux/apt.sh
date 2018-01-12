#!/bin/bash -eux

if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
	export DEBIAN_FRONTEND=noninteractive
	
	echo "==> Updating list of repositories"
    # apt-get update does not actually perform updates, it just downloads and indexes the list of packages
    apt-get -y update

    echo "==> Performing dist-upgrade (all packages and kernel)"
    apt-get -y dist-upgrade --force-yes
fi