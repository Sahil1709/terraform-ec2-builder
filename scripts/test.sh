#!/bin/bash
set -e

# Get script directory and project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."
KEY_FILE="$PROJECT_ROOT/.ssh/id_rsa"

cd "$PROJECT_ROOT/terraform"

# Get Terraform outputs
BASTION_IP=$(terraform output -raw bastion_public_ip)
PRIVATE_IPS=$(terraform output -json private_instance_ips | jq -r '.[]')

# Verify SSH key exists
if [ ! -f "$KEY_FILE" ]; then
  echo "Error: SSH key not found at $KEY_FILE"
  exit 1
fi

# Set proper permissions (in case they were modified)
chmod 600 "$KEY_FILE"

ssh-add $KEY_FILE

# Test SSH to bastion
echo "Testing SSH to bastion host ($BASTION_IP)..."
ssh -i $KEY_FILE -o StrictHostKeyChecking=no -o ConnectTimeout=10 ec2-user@$BASTION_IP \
  "echo 'Successfully connected to bastion host'"

# Test SSH to private instances through bastion
for IP in $PRIVATE_IPS; do
  echo "Testing connection to private instance ($IP)..."
  ssh -i $KEY_FILE -o StrictHostKeyChecking=no -o ConnectTimeout=10 \
    -J ec2-user@$BASTION_IP ec2-user@$IP \
    "echo 'Successfully connected to private instance'"
done


echo "All tests completed successfully!"