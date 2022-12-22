## Database HML

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