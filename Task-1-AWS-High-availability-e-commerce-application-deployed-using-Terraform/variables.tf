variable "availability_zone" {
  type    = list(string)
  default = ["us-west-1b", "us-west-1a"]
}

variable "subnetCidrBlock" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
