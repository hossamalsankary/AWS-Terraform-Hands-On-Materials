output "Vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "Puplic_subnet_id_1" {
  value = aws_subnet.public_10_0_0_0.id
}

output "Puplic_subnet_id_2" {
  value = aws_subnet.public_10_0_1_0.id
}

output "Privet_subnet_id_1" {
  value = aws_subnet.privet_10_0_2_0.id
}

output "Privet_subnet_id_2" {
  value = aws_subnet.privet_10_0_3_0.id
}

output "web_security_group" {
  value = aws_security_group.security_group.id
}