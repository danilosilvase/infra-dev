terraform {
  backend "s3" {
    bucket     = "delbank-terraform-backend"
    key        = "state/terraform.tfstate"
    region     = "us-east-1"
    encrypt    = true
    kms_key_id = "alias/terraform-bucket-key"
  }
}

provider "aws" {
  region  = local.region
}


locals {
  name   = "delbank-infra" ## Atualize com o nome do ambiente
  region = "us-east-1"     ## Atualize com a regiao
  tags = {
    Name     = local.name
    Ambiente = "dev"
  }
}

################################################################################
# Computing
################################################################################
module "computing" {
  source                         = "../../modules/computing"
  vpc_hml_default_security_group = module.networking.vpc_hml_default_security_group
  private_subnet_hlm_2           = module.networking.private_subnet_hlm_2
}

################################################################################
# Networking
################################################################################
module "networking" {
  source = "../../modules/networking"
}


# ################################################################################
# # RDS Module
# ################################################################################

module "database" {
  source     = "../../modules/database"
  vpc_id     = module.networking.vpc_id_hml
  subnet_ids = module.networking.private_subnets_list
  name       = "sv-db-prod"
  # password                 = var.password
  db_subnet_group_name     = "grupo  de sub-redes rds db prod"
  create_subnet_group_name = false
}