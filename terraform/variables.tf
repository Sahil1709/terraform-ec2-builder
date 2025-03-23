variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "my_ip" {
  description = "Your IP address for SSH (CIDR format, e.g., 12.34.56.78/32)"
  type        = string
}

variable "custom_ami_id" {
  description = "The custom AMI ID created using Packer"
  type        = string
}

variable "key_name" {
  description = "The name of the EC2 key pair"
  type        = string
  default     = "vockey"
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "private_instance_type" {
  description = "Instance type for private instances"
  type        = string
  default     = "t2.micro"
}

variable "num_private_instances" {
  description = "Number of private EC2 instances"
  type        = number
  default     = 6
}
