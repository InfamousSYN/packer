Packer
=========
Packer an automation and provisioning tool. This repositories aims to provide users with a clean and easy packer environment for the automation of building Vagrant base boxes in a consistent and streamline manner. 

Wiki: https://github.com/InfamousSYN/packer/wiki/

Running: `packer build -only=hyperv-iso -on-error=ask -var-file ./uservars-hyperv.json ./templates/kali-hyperv.json`
