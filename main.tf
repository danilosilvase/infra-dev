provider "aws" {
  region  = local.region
  profile = "delbank"
}

locals {
  name   = "dev-mssql" ## Atualize com o nome do database
  region = "us-east-1" ## Atualize com a regiao

  vpc_cidr   = "10.0.0.0/16"                                             ## Atualize com o CIDR da VPC
  vpc_id     = "vpc-71568808"                                            ## Atualize o VPC ID
  subnet_ids = ["subnet-f63b3090", "subnet-0a7a6042", "subnet-d71a4e8d"] ## Atualize com as subnets Ids

  tags = {
    Name     = local.name
    Ambiente = "dev"
  }
}

################################################################################
# EC2 Insntance
################################################################################


## SV-APP-HOMOLOG
resource "aws_instance" "AppServerHml" {
  ami                                  = "ami-0e3f439cc5945f32b"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1a"
  cpu_core_count                       = 2
  cpu_threads_per_core                 = 2
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3a.xlarge"
  key_name                             = "winaws"
  monitoring                           = false
  source_dest_check                    = true
  subnet_id                            = "subnet-04469abdf4bd373a4"
  tags = {
    "Name" = "SV-APP-HOMOLOG"
  }
  tags_all = {
    "Name" = "SV-APP-HOMOLOG"
  }
  tenancy = "default"
  vpc_security_group_ids = [
    "sg-08f56b25ac57ca730",
  ]

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  enclave_options {
    enabled = false
  }

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
  }

  private_dns_name_options {}

  root_block_device {
    delete_on_termination = false
    encrypted             = false
    iops                  = 180
    tags = {
      "Name" = "SV-APP-HOMOLOG"
    }
    throughput  = 0
    volume_size = 60
    volume_type = "gp2"
  }
}

# ################################################################################
# # Networking
# ################################################################################
resource "aws_vpc" "vpc_hml" {
  assign_generated_ipv6_cidr_block     = true
  cidr_block                           = "10.2.0.0/16"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  tags = {
    "Name" = "delcred-vpc-homolog"
  }
  tags_all = {
    "Name" = "delcred-vpc-homolog"
  }
}

resource "aws_subnet" "public_subnet_hlm_1" {
  vpc_id                  = aws_vpc.vpc_hml.id
  cidr_block              = "10.2.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "subnet-application-homolog_4-publica"
  }
  tags_all = {
    "Name" = "subnet-application-homolog_4-publica"
  }
}

resource "aws_subnet" "public_subnet_hlm_2" {
  vpc_id                          = aws_vpc.vpc_hml.id
  assign_ipv6_address_on_creation = false
  availability_zone               = "us-east-1a"
  cidr_block                      = "10.2.5.0/24"
  enable_dns64                    = false
  map_public_ip_on_launch         = true
  tags = {
    "Name" = "subnet-application-homolog_5-publica"
  }
  tags_all = {
    "Name" = "subnet-application-homolog_5-publica"
  }
}

resource "aws_subnet" "private_subnet_hlm_1" {
  vpc_id                  = aws_vpc.vpc_hml.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.2.1.0/24"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "subnet-database-homolog_1-privado"
  }
  tags_all = {
    "Name" = "subnet-database-homolog_1-privado"
  }
}

resource "aws_subnet" "private_subnet_hlm_2" {
  vpc_id     = aws_vpc.vpc_hml.id
    availability_zone                              = "us-east-1a"
    cidr_block                                     = "10.2.2.0/24"
    map_public_ip_on_launch                        = false
    tags                                           = {
        "Name" = "subnet-application-homolog_2-privado"
    }
    tags_all                                       = {
        "Name" = "subnet-application-homolog_2-privado"
    }
}

resource "aws_subnet" "private_subnet_hlm_3" {
  vpc_id     = aws_vpc.vpc_hml.id
    availability_zone                              = "us-east-1b"
    cidr_block                                     = "10.2.3.0/24"
    map_public_ip_on_launch                        = false
    tags                                           = {
        "Name" = "subnet-application-homolog_3-privado"
    }
    tags_all                                       = {
        "Name" = "subnet-application-homolog_3-privado"
    }
}

# ################################################################################
# # RDS Module
# ################################################################################

# module "db" {
#   source  = "terraform-aws-modules/rds/aws"
#   version = "5.2.2"

#   identifier = local.name

#   engine               = "sqlserver-se"
#   engine_version       = "15.00"
#   family               = "sqlserver-se-15.0" # DB parameter group
#   major_engine_version = "15.00"             # DB option group
#   instance_class       = "db.t3.xlarge"

#   allocated_storage     = 100
#   max_allocated_storage = 200

#   # Encryption at rest
#   storage_encrypted = true

#   username = "admin"
#   port     = 1433

#   # domain               = aws_directory_service_directory.demo.id
#   # domain_iam_role_name = aws_iam_role.rds_ad_auth.name

#   multi_az               = false
#   vpc_security_group_ids = [module.security_group.security_group_id]

#   maintenance_window              = "Mon:00:00-Mon:03:00"
#   backup_window                   = "03:00-06:00"
#   enabled_cloudwatch_logs_exports = ["error", "agent"]
#   create_cloudwatch_log_group     = true

#   backup_retention_period = 7
#   skip_final_snapshot     = true
#   deletion_protection     = true

#   performance_insights_enabled          = false
#   performance_insights_retention_period = 7
#   create_monitoring_role                = true
#   monitoring_interval                   = 60

#   options                   = []
#   create_db_parameter_group = false
#   license_model             = "license-included"
#   timezone                  = "GMT Standard Time"
#   character_set_name        = "Latin1_General_CI_AS"

#   tags = local.tags

#   # DB subnet group
#   create_db_subnet_group = true
#   subnet_ids             = local.subnet_ids

# }

# ################################################################################
# # Supporting Resources
# ################################################################################

# # Security Group
# module "security_group" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 4.0"

#   name        = local.name
#   description = "SqlServer security group"
#   vpc_id      = local.vpc_id

#   # ingress
#   ingress_with_cidr_blocks = [
#     {
#       from_port   = 1433
#       to_port     = 1433
#       protocol    = "tcp"
#       description = "SqlServer access from within VPC"
#       cidr_blocks = "0.0.0.0/0,10.1.1.0/32"
#     },
#   ]

#   # egress
#   egress_with_cidr_blocks = [
#     {
#       from_port   = 0
#       to_port     = 0
#       protocol    = -1
#       description = "Allow outbound communication to Directory Services security group"
#       cidr_blocks = "0.0.0.0/0"
#     },
#   ]

#   tags = local.tags
# }