#!/bin/bash
#Quick commands to get Terraform installed on Amazon Linux 2
#Should work on other Linux releases but this is the only version I tested
#Copy and run from /tmp
#Chad Smith - 11/06/2019
wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip
unzip terraform_0.12.28_linux_amd64.zip
sudo mv terraform /usr/local/bin/ && rm terraform_0.12.28_linux_amd64.zip
sudo ln -s /usr/local/bin/terraform /usr/bin/
terraform --version

