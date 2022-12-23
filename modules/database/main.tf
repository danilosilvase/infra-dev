# provider "aws" {
#   region = local.region
#   #   profile = "delbank"
# }

# locals {

#   region = "us-east-1" ## Atualize com a regiao
#   tags = {
#     Name     = local.name
#     Ambiente = "dev"
#   }
#   name = var.name
#   #   name_prefix = var.use_name_prefix ? "${var.name}-" : null

#   #   description = coalesce(var.description, format("%s subnet group", var.name))
# }

# Ref. https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces
data "aws_partition" "current" {}

## Database HML

resource "aws_db_instance" "database_hml" {
  allocated_storage          = var.allocated_storage
  auto_minor_version_upgrade = false
  backup_retention_period    = 7
  backup_window              = "21:00-21:30"
  ca_cert_identifier         = "rds-ca-2019"
  character_set_name         = "SQL_Latin1_General_CP1_CI_AS"
  copy_tags_to_snapshot      = true
  customer_owned_ip_enabled  = false
  db_subnet_group_name       = var.create_subnet_group_name ? aws_db_subnet_group.this.name : var.db_subnet_group_name
  delete_automated_backups   = true
  deletion_protection        = true
  enabled_cloudwatch_logs_exports = [
    "agent",
    "error",
  ]
  engine                                = var.engine_name
  engine_version                        = "15.00.4073.23.v1"
  iam_database_authentication_enabled   = false
  identifier                            = var.name
  instance_class                        = var.instance_class
  iops                                  = 0
  license_model                         = "license-included"
  maintenance_window                    = "sat:00:00-sat:00:30"
  max_allocated_storage                 = 200
  monitoring_interval                   = 60
  monitoring_role_arn                   = aws_iam_role.enhanced_monitoring[0].arn
  multi_az                              = false
  network_type                          = "IPV4"
  option_group_name                     = "default:sqlserver-se-15-00"
  parameter_group_name                  = "default.sqlserver-se-15.0"
  performance_insights_enabled          = false
  performance_insights_retention_period = 0
  port                                  = 1433
  publicly_accessible                   = false
  skip_final_snapshot                   = true
  storage_encrypted                     = true
  storage_throughput                    = 0
  storage_type                          = "gp2"
  tags                                  = {}
  tags_all                              = {}
  timezone                              = "Central Brazilian Standard Time"
  username                              = "admin"
  # password                              = var.password
  # vpc_security_group_ids                = [
  #     "sg-0ac8663274c45ebfe",
  # ]
}

resource "aws_db_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids
}

################################################################################
# Enhanced monitoring
################################################################################

data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "enhanced_monitoring" {
  count              = 1
  assume_role_policy = data.aws_iam_policy_document.enhanced_monitoring.json
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role       = aws_iam_role.enhanced_monitoring[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}