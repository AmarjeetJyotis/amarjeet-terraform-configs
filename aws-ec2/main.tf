terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.62.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
  ami           = "ami-0ac7b260cf76d8865"
  instance_type = "t2.micro"

  tags = {
    Name = "SampleServer"
  }
}
