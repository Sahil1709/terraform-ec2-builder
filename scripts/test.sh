#!/bin/bash
set -e

# Get script directory and project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."

cd "$PROJECT_ROOT/terraform"

# Get Terraform outputs
BASTION_IP=$(terraform output -raw bastion_public_ip)

# Verify SSH key exists
if [ ! -f "$SSH_KEY_PATH" ]; then
  echo "Error: SSH key not found at $SSH_KEY_PATH"
  exit 1
fi

# Set proper permissions (in case they were modified)
chmod 600 "$SSH_KEY_PATH"

ssh-add $SSH_KEY_PATH

# Test SSH to bastion
echo "Testing SSH to bastion host ($BASTION_IP)..."
ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no -o ConnectTimeout=10 ec2-user@$BASTION_IP <<EOF
  echo 'Successfully connected to bastion host'
  cd /terraform-ec2-builder/ansible
  ansible all -i aws_ec2.yml -a "docker --version"
EOF


echo "All tests completed successfully!"