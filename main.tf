provider "aws" {
  region = local.region
}

locals {
  name   = "dev-mssql" ## Atualize com o nome do database
  region = "eu-west-1" ## Atualize com a regiao

  vpc_cidr   = "10.0.0.0/16"                                             ## Atualize com o CIDR da VPC
  vpc_id     = "vpc-71568808"                                            ## Atualize o VPC ID
  subnet_ids = ["subnet-f63b3090", "subnet-0a7a6042", "subnet-d71a4e8d"] ## Atualize com as subnets Ids

  tags = {
    Name     = local.name
    Ambiente = "dev"
  }
}

################################################################################
# RDS Module
################################################################################

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.2.2"

  identifier = local.name

  engine               = "sqlserver-se"
  engine_version       = "15.00"
  family               = "sqlserver-se-15.0" # DB parameter group
  major_engine_version = "15.00"             # DB option group
  instance_class       = "db.t3.xlarge"

  allocated_storage     = 100
  max_allocated_storage = 200

  # Encryption at rest
  storage_encrypted = true

  username = "admin"
  port     = 1433

  # domain               = aws_directory_service_directory.demo.id
  # domain_iam_role_name = aws_iam_role.rds_ad_auth.name

  multi_az               = false
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["error", "agent"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = true

  performance_insights_enabled          = false
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  options                   = []
  create_db_parameter_group = false
  license_model             = "license-included"
  timezone                  = "GMT Standard Time"
  character_set_name        = "Latin1_General_CI_AS"

  tags = local.tags

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = local.subnet_ids

}

################################################################################
# Supporting Resources
################################################################################

# Security Group
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "SqlServer security group"
  vpc_id      = local.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 1433
      to_port     = 1433
      protocol    = "tcp"
      description = "SqlServer access from within VPC"
      cidr_blocks = "0.0.0.0/0,10.1.1.0/32"
    },
  ]

  # egress
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Allow outbound communication to Directory Services security group"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = local.tags
}