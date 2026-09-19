# terraform-aws-vpc

## Overview

This Terraform module creates an AWS VPC with a given CIDR block.
It also creates multiple public and private subnets.

For public subnets, it creates an Internet Gateway (IGW) and
appropriate route tables to allow internet access.

## Features

- Creates a VPC with a specified CIDR block
- Creates multiple public and private subnets
- Creates an Internet Gateway (IGW) for public subnets
- Creates route tables for public subnets
- Associates public subnets with the public route table
- Provides subnet details as module outputs

## Usage


```hcl
module "vpc" {
  source = "./modules/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "your_vpc_name"
  }

  subnet_config = {
    public_subnet = {
      cidr_block = "10.0.0.0/24"
      az         = "ap-south-1a"
      #To set the subnet as public, default is private
      public     = true
    }

    private_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-south-1b"
    }
  }
}