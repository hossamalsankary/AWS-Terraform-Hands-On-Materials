output "aws_elb" {
  value = aws_elb.web_elb.dns_name
}
