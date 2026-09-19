terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.62.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Data source to fetch the latest Amazon Linux 2 AMI
data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]
}

# Data source to fetch the default security group by tag
data "aws_security_group" "name" {
  tags = {
    mywebserver = "http"
  }
}

# VPC Id
data "aws_vpc" "name" {
  tags = {
    Name = "my-vpc"
  }
}

# Avalibality Zone
data "aws_availability_zones" "available" {
  state = "available"
}

# to get the account details
data "aws_caller_identity" "current" {

}
output "aws_account_id" {
  description = "The AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_ami_id" {

  description = "The ID of the latest AMI"
  value       = data.aws_ami.name.id
}

output "aws_security_group_id" {
  description = "The ID of the default security group"
  value       = data.aws_security_group.name.id
}

output "aws_vpc_id" {
  description = "The ID of the default VPC"
  value       = data.aws_vpc.name.id
}

output "aws_availability_zones" {
  description = "The list of available availability zones"
  value       = data.aws_availability_zones.available.names
}

# ec2 machine
resource "aws_instance" "myserver" {
  ami           = data.aws_ami.name.id
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}
