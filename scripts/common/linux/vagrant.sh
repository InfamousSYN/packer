#!/bin/sh -eux

# Checks if the vagrant user has already been created
if getent passwd "vagrant" > /dev/null 2>&1; then
    true
else
    # create standard vagrant user and then set password
    useradd -d /home/vagrant -m -s /bin/bash vagrant
    echo "vagrant:vagrant" |chpasswd
fi	

# set root user's password to vagrant
echo "root:vagrant" | chpasswd

# Create a sudoers entry for the new vagrant user
echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant

# set a default HOME_DIR environment variable if not set
HOME_DIR="${HOME_DIR:-/home/vagrant}";

pubkey_url="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub";
mkdir -p $HOME_DIR/.ssh;
if command -v wget >/dev/null 2>&1; then
    wget --no-check-certificate "$pubkey_url" -O $HOME_DIR/.ssh/authorized_keys;
elif command -v curl >/dev/null 2>&1; then
    curl --insecure --location "$pubkey_url" > $HOME_DIR/.ssh/authorized_keys;
elif command -v fetch >/dev/null 2>&1; then
    fetch -am -o $HOME_DIR/.ssh/authorized_keys "$pubkey_url";
else
    echo "Cannot download vagrant public key";
    exit 1;
fi
chown -R vagrant $HOME_DIR/.ssh;
chmod -R go-rwsx $HOME_DIR/.ssh;

# Disable password based SSH for all users now that we have a key in place
if $(grep -q '^PasswordAuthentication yes' /etc/ssh/sshd_config)
then
    sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
else
    echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
fi