terraform {
  required_version = ">= 1.5.0" # Constrains the Terraform CLI version itself

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # This is the version constraint syntax
    }
  }
}
