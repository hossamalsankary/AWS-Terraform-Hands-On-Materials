variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "privet_subnets" {
  type = list(string)

}
variable "public_subnets" {
  type = list(string)
}

variable "web_security_group" {
  type = string

}

variable "availability_zone" {
  type = list(string)

}
