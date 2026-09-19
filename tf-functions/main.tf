terraform {

}

locals {
  value = "Hello World"
}

variable "string_list" {
  type    = list(string)
  default = ["Amarjeet", "Kamaljeet", "Rohit", "Amarjeet"]
}

output "output" {
  #   value = upper(local.value)
  #   value = startswith(local.value, "hello")
  #   value = split(" ", local.value)
  #   value = min(1, 2, 3, 4, 5)
  #   value = max(1, 2, 3, 4, 5)
  #   value=abs(-10)
  #   value = length(var.string_list)
  #   value = join(":", var.string_list)
  #   value = contains(var.string_list, "Amarjeet")
  value = toset(var.string_list)

}
