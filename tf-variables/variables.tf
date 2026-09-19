variable "aws_instance_type" {
  description = "What  type of instance to create"
  type        = string
  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.aws_instance_type)
    error_message = "Invalid instance type. Allowed values are: t2.micro, t3.micro"
  }
}

variable "ec2_config" {
  description = "EC2 instance configuration"
  type = object({
    volume_size = number
    volume_type = string
  })
  default = {
    volume_size = 20
    volume_type = "gp2"
  }
}
