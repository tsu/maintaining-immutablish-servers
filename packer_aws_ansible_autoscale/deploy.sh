#!/bin/bash

set -o nounset
set -o errexit

timestamp=$(date +%Y%m%d_%H%M%S)
ami_name=immutablish-web-server-${timestamp}

./bake_ami.sh $ami_name
ami_id=$(./lookup_ami_id.sh $ami_name)
ansible-playbook autoscale-playbook.yml -i inventory --extra-vars "ami_id=${ami_id} vpc_id=${vpc_id}"
