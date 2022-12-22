variable "name" {
    type = string
    default = "hml-database"
    description = "value"
}

variable "subnet_ids_hml" {
  type    = list(string)
  default = ["subnet-f63b3090", "subnet-0a7a6042", "subnet-d71a4e8d"]
    description = "value"
}

variable "vpc_id_hml" {
  type    = string
  description = "value"
}

