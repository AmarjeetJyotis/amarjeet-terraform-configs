terraform {
}

# Number List
variable "num_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}

# Object List of persons
variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [
    {
      fname = "Amarjeet"
      lname = "Kumar"
    },
    {
      fname = "Kamaljeet"
      lname = "Kumar"
    }
  ]
}

# Mapping for values
variable "map_list" {
  type = map(string)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
  }
}

# Calculation 
locals {
  add = 2 + 2
  mul = 2 * 8
  eq  = 2 != 3

  # double the list of numbers
  double_list = [for num in var.num_list : num * 2]

  #   only odd number from the list
  odd_list = [for num in var.num_list : num if num % 2 != 0]

  #   first name of all persons in the list
  first_name_list = [for person in var.person_list : person.fname]

  #   work with map list
  map_list_values = [for key, value in var.map_list : value * 2]

  double_map = { for key, value in var.map_list : key => value * 2 }
}

output "output" {
  value = local.double_map
}
