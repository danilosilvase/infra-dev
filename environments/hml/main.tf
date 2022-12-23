provider "aws" {
  region  = local.region
  profile = "delbank"
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
  cidr = "10.1.0.0/16"
}


# ################################################################################
# # RDS Module
# ################################################################################

module "computing" {
  source                         = "../../modules/computing"
  vpc_hml_default_security_group = module.networking.vpc_hml_default_security_group
  private_subnet_hlm_2           = module.networking.private_subnet_hlm_2
}