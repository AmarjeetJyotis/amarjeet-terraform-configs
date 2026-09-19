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

locals {
  owner = "Amarjeet"
  name  = "SampleServer"

}

// Optional map of additional tags to merge with the resource tags
variable "additional_tags" {
  type    = map(string)
  default = {}
}

resource "aws_instance" "myserver" {
  ami           = "ami-0ac7b260cf76d8865"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_config.volume_size
    volume_type           = var.ec2_config.volume_type
  }

  tags = merge(var.additional_tags, {
    Name = local.name
    }
  )
}
