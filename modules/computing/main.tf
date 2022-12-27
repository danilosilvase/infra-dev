
## SV-APP-HOMOLOG
resource "aws_instance" "app-server-hml" {
  ami                                  = "ami-0e3f439cc5945f32b"
  associate_public_ip_address          = true
  cpu_core_count                       = 2
  cpu_threads_per_core                 = 2
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  instance_type                        = "t3a.xlarge"
  key_name                             = "winaws"
  monitoring                           = false
  source_dest_check                    = true
  subnet_id                            = var.private_subnet_hlm_2
  tags = {
    "Name" = "SV-APP-HOMOLOG"
  }
  tags_all = {
    "Name" = "SV-APP-HOMOLOG"
  }
  tenancy = "default"
  vpc_security_group_ids = [
    var.vpc_hml_default_security_group,
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


## Database Server HML
resource "aws_instance" "db_server_hml" {
  ami                         = "ami-06ff0710ea188e2c7"
  associate_public_ip_address = false
  cpu_core_count              = 2
  cpu_threads_per_core        = 2
  disable_api_stop            = false
  disable_api_termination     = true
  ebs_optimized               = true
  get_password_data           = false
  hibernation                 = false
  instance_type               = "t3a.xlarge"
  key_name                    = "winaws"
  monitoring                  = false
  security_groups             = []
  source_dest_check           = true
  subnet_id                   = "subnet-0911da03f38fbb72d"
  tags = {
    "Name" = "SV-DB-HOMOLOG"
  }
  tags_all = {
    "Name" = "SV-DB-HOMOLOG"
  }
  tenancy = "default"
  vpc_security_group_ids = [
    "sg-0dc5e03e063e668a6"
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

}