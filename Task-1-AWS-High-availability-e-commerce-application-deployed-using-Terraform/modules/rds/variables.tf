variable "vpc_id" {
  type = string
}

variable "privet_subnets" {
  type = list(string)

}

variable "instance_class" {
  type = string
  default = "db.r5.large"
}


variable "engine_version" {
  type = string
  default = "14.5"
}

variable "engine" {
  type = string
  default = "aurora-postgresql"
}

variable "username" {
  type = string
  default = "root"
}

variable "password" {
  type = string
  default = "root"
}