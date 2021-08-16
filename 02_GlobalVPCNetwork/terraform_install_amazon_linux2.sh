#!/bin/bash
  
cd /tmp
TERRAFORM_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest |  grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip
sudo yum -y install unzip
unzip terraform_${TERRAFORM_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/

