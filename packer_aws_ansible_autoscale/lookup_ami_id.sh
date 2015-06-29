#!/bin/bash

set -o nounset
set -o errexit

ami_name=$1
aws_access_key=$(grep aws_access_key_id ~/.aws/credentials|head -1|cut -f 3 -d ' ')
aws_secret_key=$(grep aws_secret_access_key ~/.aws/credentials|head -1|cut -f 3 -d ' ')

function lookup_ami_id() {
  aws ec2 describe-images --filters "Name=name,Values=${ami_name}"|jq --raw-output '.Images[0].ImageId'
}

lookup_ami_id
