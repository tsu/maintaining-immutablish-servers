#!/bin/bash

set -o nounset
set -o errexit

ami_name=$1
packer_template=webserver-packer.json
aws_access_key=$(grep aws_access_key_id ~/.aws/credentials|head -1|cut -f 3 -d ' ')
aws_secret_key=$(grep aws_secret_access_key ~/.aws/credentials|head -1|cut -f 3 -d ' ')

function bake_ami() {
  packer build -var "aws_access_key=$aws_access_key" -var "aws_secret_key=$aws_secret_key" -var "ami_name=$ami_name" $packer_template
}

bake_ami
