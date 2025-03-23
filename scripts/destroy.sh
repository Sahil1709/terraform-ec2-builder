#!/bin/bash

ROOT_DIR=$(pwd)
source "${ROOT_DIR}/.env"
cd "${ROOT_DIR}/packer"

# Extract AMI ID from Packer output
AMI_ID=$(grep -Eo 'ami-[0-9a-f]{17}' packer.log | tail -1)
echo "Created AMI ID: ${AMI_ID}"

# Get public IP
MY_IP=$(curl -s ifcfg.me)/32
echo "Detected public IP: ${MY_IP}"

cd "${ROOT_DIR}/terraform"
# Run the terraform destroy command to destroy the infrastructure
terraform destroy \
    -auto-approve \
    -var="custom_ami_id=${AMI_ID}" \
    -var="my_ip=${MY_IP}"