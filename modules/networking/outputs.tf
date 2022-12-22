output "vpc_hml_default_security_group" {
  description = "The default security group of the HML VPC"
  value       = aws_security_group.default-sg-hml.id
}

output "private_subnet_hlm_2" {
  description = "The private subnet 2 for HML VPC"
  value       = aws_subnet.private_subnet_hml_2.id
}