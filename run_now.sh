#!/bin/bash
set -e

# Set paths
ROOT_DIR=$(pwd)
PACKER_DIR="${ROOT_DIR}/packer"
TERRAFORM_DIR="${ROOT_DIR}/terraform"

source .env

# Build Packer image
echo "Building Packer AMI..."
cd "${PACKER_DIR}"
packer build amazon-linux.json | tee packer.log

# Extract AMI ID from Packer output
AMI_ID=$(grep -Eo 'ami-[0-9a-f]{17}' packer.log | tail -1)
echo "Created AMI ID: ${AMI_ID}"

# Get public IP
MY_IP=$(curl -s ifcfg.me)/32
echo "Detected public IP: ${MY_IP}"

# Run Terraform
echo "Initializing Terraform..."
cd "${TERRAFORM_DIR}"
terraform init

echo "Planning infrastructure..."
terraform plan \
  -var="custom_ami_id=${AMI_ID}" \
  -var="my_ip=${MY_IP}"

echo "Applying infrastructure..."
terraform apply \
  -var="custom_ami_id=${AMI_ID}" \
  -var="my_ip=${MY_IP}" \
  -auto-approve

echo "Deployment complete!"