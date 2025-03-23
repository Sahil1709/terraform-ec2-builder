
# AWS Infrastructure with Custom AMI and Terraform Provisioning

This repository contains the infrastructure-as-code for creating a custom AWS environment using a custom Amazon Machine Image (AMI) built with Packer and provisioning the necessary AWS resources with Terraform.

## Overview

This project automates the following:

1. **Custom AWS AMI Creation using Packer**  
   - **Base OS:** Amazon Linux  
   - **Installed Software:** Docker  
   - **SSH Configuration:** Your SSH public key is automatically added to allow login using your private key

2. **AWS Infrastructure Provisioning using Terraform**  
   The Terraform scripts in this repo provision the following resources:
   - A new VPC with both public and private subnets
   - All necessary routing (Internet gateway, NAT gateway, route tables)
   - One bastion host in the public subnet that only accepts SSH connections (port 22) from your IP address
   - Six EC2 instances in the private subnet, all launched using the custom AMI created via Packer

## Repository Structure

```
.
├── packer/                  
│   ├── amazon-linux.json    # Packer template for custom AMI
├── terraform/
│   ├── main.tf              # Main Terraform configuration
│   ├── variables.tf         # Terraform variables definition
│   ├── outputs.tf           # Terraform outputs
├── .env.example             # example env file
└── README.md                # This file
```

## Prerequisites

- [Packer](https://www.packer.io/) installed on your local machine
- [Terraform](https://www.terraform.io/) installed on your local machine
- AWS CLI credentials ready
- Your SSH public key ready

## How to Run the Project

### 1. Edit .env.example
```sh
AWS_ACCESS_KEY=
AWS_SECRET_KEY=
AWS_SESSION_TOKEN=
AWS_REGION=us-east-1
SSH_PUBLIC_KEY=
```

### 2. Run the script
```sh
chmod +x run_now.sh
./run_now.sh
```

### 3. Verify the Deployment:
- Check your AWS console to see the new VPC, bastion host, and private EC2 instances.
- Log in to the bastion host (using your private key) to verify network connectivity.
- Use the public Elastic IP associated with your bastion host to access the instances if needed.

## Expected Outputs

- **Packer:** A custom AMI with Docker installed and your SSH key configured.
- **Terraform:** A new VPC with public and private subnets, one bastion host (accessible via your IP on port 22), and 6 EC2 instances in the private subnet launched with the custom AMI.

## Screenshots

- ![Packer Build Output](screenshots/packer-build.png)

- ![Terraform Apply Output](screenshots/terraform-apply.png)


## Conclusion

This project demonstrates the use of Packer to create a custom AWS AMI and Terraform to provision a complete AWS environment, including VPC, subnets, bastion host, and EC2 instances. All resources are configured with precise network settings, security rules, and integration with an RDS database. The comprehensive README and included screenshots ensure that every step—from AMI creation to final deployment—can be replicated and understood.

---

