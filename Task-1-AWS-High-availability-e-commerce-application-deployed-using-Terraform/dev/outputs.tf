output "Puplic_subnet_id_1" {
  value = module.vpc.Puplic_subnet_id_1
}

output "Puplic_subnet_id_2" {
  value = module.vpc.Puplic_subnet_id_2
}

output "Privet_subnet_id_1" {
  value = module.vpc.Privet_subnet_id_1
}

output "Privet_subnet_id_2" {
  value = module.vpc.Privet_subnet_id_2
}

output "aws_elb" {
  value = module.comput.aws_elb
}