variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zone" {
  type = list(string)

}

variable "subnetCidrBlock" {
  type = list(string)


}
variable "allTraffiCblock" {
  type    = string
  default = "0.0.0.0/0"
}
