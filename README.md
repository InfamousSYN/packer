Packer
=========
Packer an automation and provisioning tool. This repositories aims to provide users with a clean and easy packer environment for the automation of building Vagrant base boxes in a consistent and streamline manner. 

## Remote Builds

```
packer build -only=vmware-iso -var 'iso_url=ubuntu-14.04.6-server-amd64.iso' -var 'iso_checksum=B17D7C1E9D0321AD5810BA77B69AEF43F0F29A5422B08120E6EE0576C4527C0E' -var 'account_name=username' -var 'account_key=api-key' -var 'box_version=box-version' .\templates\trusty64.json
vagrant box add {{account_name}}/{{box_name}}
```

## Local Builds
By design these packer templates use the `post-processors` block to upload resulting golden image to a designated [vagrant-cloud](https://app.vagrantup.com/) location for storage. For local builds, the [jq](https://stedolan.github.io/jq/download/) can be used at runtime to strip the `post-processors` block from the used template. 

The below example removes the second `post-processors` action, which is the `vagrant-cloud` action that uploads the produced artifact to vagrant cloud. 
```
jq --arg pp "post-processors" 'del(.[$pp][0][1])' .\templates\trusty64.json | packer build -only=vmware-iso -var 'iso_url=ubuntu-14.04.6-server-amd64.iso' -var "metadata=packer\include\vagrant\metadata\vmware\desktop\metadata.json" -var 'vagrantfile=packer\build\Vagrantfile' -var 'iso_checksum=B17D7C1E9D0321AD5810BA77B69AEF43F0F29A5422B08120E6EE0576C4527C0E' -
```
