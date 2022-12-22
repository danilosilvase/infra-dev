output "vpc_hml_default_security_group" {
  description = "The default security group of the HML VPC"
  value       = aws_security_group.default-sg-hml.id
}

output "private_subnet_hlm_2" {
  description = "The private subnet 2 for HML VPC"
  value       = aws_subnet.private_subnet_hml_2.id
}

output "vpc_id_hml" {
  description = "The VPC Id for HML VPC"
  value       = aws_vpc.vpc_hml.id
}

output "subnet_ids_hml" {
  description = "The Subnets Ids for HML VPC"
  value       = [aws_subnet.private_subnet_hml_1.id, aws_subnet.private_subnet_hml_2.id]
}