variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "privet_subnets" {
  type = list(string)

}


