# TODO:

A.  Create a custom AWS AMI using Packer that contains the following:

Amazon Linux
Docker
Your SSH public key is set so you can login using your private key
B.  Terraform scripts to provision AWS resources:

VPC, private subnets, public subnets, all necessary routes (use modules)
1 bastion host in the public subnet (accept only your IP on port 22)
6 EC2 instances in the private subnet using your new AMI created from Packer
