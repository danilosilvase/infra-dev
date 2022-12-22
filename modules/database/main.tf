# module "db" {
#   source  = "terraform-aws-modules/rds/aws"
#   version = "5.2.2"

#   identifier = var.name

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

# #   tags = local.tags

#   # DB subnet group
#   create_db_subnet_group = true
#   subnet_ids             = var.subnet_ids_hml

# }

# ################################################################################
# # Supporting Resources
# ################################################################################

# # Security Group
# module "security_group" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 4.0"

#   name        = var.name
#   description = "SqlServer security group"
#   vpc_id      = var.vpc_id_hml

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

# #   tags = local.tags
# }

resource "aws_db_instance" "database_hml" {
    allocated_storage                     = 99
    auto_minor_version_upgrade            = false
    backup_retention_period               = 7
    backup_window                         = "21:00-21:30"
    ca_cert_identifier                    = "rds-ca-2019"
    character_set_name                    = "SQL_Latin1_General_CP1_CI_AS"
    copy_tags_to_snapshot                 = true
    customer_owned_ip_enabled             = false
    db_subnet_group_name                  = "grupo  de sub-redes rds db prod"
    delete_automated_backups              = true
    deletion_protection                   = true
    enabled_cloudwatch_logs_exports       = [
        "agent",
        "error",
    ]
    engine                                = "sqlserver-se"
    engine_version                        = "15.00.4073.23.v1"
    iam_database_authentication_enabled   = false
    identifier                            = "sv-db-prod"
    instance_class                        = "db.t3.xlarge"
    iops                                  = 0
    kms_key_id                            = "arn:aws:kms:us-east-1:286358998086:key/09076054-f6c1-4022-b2db-39c337badd12"
    license_model                         = "license-included"
    maintenance_window                    = "sat:00:00-sat:00:30"
    max_allocated_storage                 = 200
    monitoring_interval                   = 60
    monitoring_role_arn                   = "arn:aws:iam::286358998086:role/rds-monitoring-role"
    multi_az                              = false
    network_type                          = "IPV4"
    option_group_name                     = "serverdb"
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
    vpc_security_group_ids                = [
        "sg-0ac8663274c45ebfe",
    ]
}