variable "vpc_config" {
  description = "To get the CIDR block and name of the VPC from the user"
  type = object({
    cidr_block = string
    name       = string
  })
  validation {
    condition     = can(cidrhost(var.vpc_config.cidr_block, 0))
    error_message = "Invalid CIDR Format - ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  description = "To get the CIDR block and AZ of the Subnet"
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))

  validation {
    condition     = alltrue([for config in var.subnet_config : can(cidrhost(config.cidr_block, 0))])
    error_message = "Invalid CIDR Format"
  }
}
