Packer
=========
Packer is used to automated the building and inital provisioning of a Vagrant base box (.box) in a consistent and streamline manner. This repositories aims to provide users with a clean and easy packer environment for the automation in building base boxes. 

Selecting A Packer Build
-----
Many of the packer templates support multiple packer builders. This is because there are slight differences in setting up a virtual machines for each of the supported providers. 

The below example will result in packer only building a vagrant base box using the `vmware-iso` builder.
```
packer build -only=vmware-iso templates/kali.json
```

The below example will result in packer only building a vagrant base box using the `virtualbox-iso` builder.
```
packer build -only=virtualbox-iso templates/kali.json
```

Local Instance Workflow
------
This workflow is aimed at describing the process of using packer to build a Vagrant base box to then add to your local Vagrant box library for later use.
1. Download the packer repository
2. Copy supporting Vagrant .box file artifacts
3. Edit support Vagrant .box file artifacts to match specific requirements. *Note: There is a Vagrantfile copy for Windows and Linux for both vmware_workstation and virtualbox providers. Likewise, there is a metadata.json for each of the supported vagrant providers.*
	* Change Vagrant provider in metadata.json file
	* Change box name in Vagrantfile
4. Edit changes in template based on specific user requirements you might have.
5. Validate the packer template after changes.
6. Perform the packer build process.
7. Add produced Vagrant base box to local Vagrant instance

```
git clone https://github.com/InfamousSYN/packer.git
cd ./packer
cp ./inclue/vagrant/metadata/virtualbox/metadata.json ./build/metadata.json 					# edit as required
cp ./include/vagrant/Vagrantfile/virtualbox/windows/Vagrantfile ./build/Vagrantfile 			# edit as required
edit ./templates/kali.json 																		# edit as required
packer validate templates/kali.json
packer build templates/kali.json
vagrant box add ./build/{{box_name}}.box --name {{box_name}}
```

Distributed Vagrant Box Workflow
------
This workflow is aimed at describing the process of using packer to build a Vagrant base box which is then uploaded to a Vagrant Cloud account to be publicly distributed across the internet.

*Note: Any packer template within this repository with the suffix of '-cloud' will attempt to upload the produced .box file to a configured Vagrant Cloud account.*
1. Download the packer repository
2. Copy supporting Vagrant .box file artifacts
3. Edit support Vagrant .box file artifacts to match specific requirements. *Note: There is a Vagrantfile copy for Windows and Linux for both vmware_workstation and virtualbox providers. Likewise, there is a metadata.json for each of the supported vagrant providers.*
	* Change Vagrant provider in metadata.json file
	* Change box name in Vagrantfile
4. Edit changes in template based on specific user requirements you might have.
	* Enter Vagrant Cloud account name
	* Enter Vagrant Cloud API key
	* Configure box version
5. Validate the packer template after changes.
6. Perform the packer build process.

For more information on the specifics of the `vagrant-cloud` post-processor workflow, refer to this knowledge base article: [https://www.packer.io/docs/post-processors/vagrant-cloud.html](https://www.packer.io/docs/post-processors/vagrant-cloud.html)

```
git clone https://github.com/InfamousSYN/packer.git
cd ./packer
cp ./inclue/vagrant/metadata/virtualbox/metadata.json ./build/metadata.json 					# edit as required
cp ./include/vagrant/Vagrantfile/virtualbox/windows/Vagrantfile ./build/Vagrantfile 			# edit as required
edit ./templates/kali.json 																		# edit as required
packer validate templates/kali-cloud.json
packer build templates/kali-cloud.json
vagrant box add {{account_name}}/{{box_name}}
```

Periodically I will upload Vagrant base boxes to my Vagrant Cloud repository, these boxes can be publicly accessed and downloaded from here: [https://app.vagrantup.com/ainfamoussyn](https://app.vagrantup.com/ainfamoussyn)