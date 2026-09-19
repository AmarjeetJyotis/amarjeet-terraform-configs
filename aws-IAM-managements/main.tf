terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

locals {
  users_data = yamldecode(file("./users.yaml")).users

  user_role_pairs = flatten([
    for user in local.users_data : [
      for role in user.roles : {
        username = user.username
        role     = role
      }
    ]
  ])

}

output "users" {
  value = local.user_role_pairs
}

#creating IAM users
resource "aws_iam_user" "users" {
  for_each = toset(local.users_data[*].username)

  name = each.value
}


# Password creation for IAM users
resource "aws_iam_user_login_profile" "profile" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}


#Attaching policies to IAM users
resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  for_each = { 
    for pair in local.user_role_pairs : 
    "${pair.username}-${pair.role}" => pair
     }

  user       = aws_iam_user.users[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}