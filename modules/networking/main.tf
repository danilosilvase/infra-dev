## VPC - HML
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

## Subnets HML
resource "aws_subnet" "public_subnet_hml_1" {
  vpc_id                  = aws_vpc.vpc_hml.id
  cidr_block              = "10.2.4.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "subnet-application-homolog_4-publica"
  }
  tags_all = {
    "Name" = "subnet-application-homolog_4-publica"
  }
}

resource "aws_subnet" "public_subnet_hml_2" {
  vpc_id                          = aws_vpc.vpc_hml.id
  assign_ipv6_address_on_creation = false
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

resource "aws_subnet" "private_subnet_hml_1" {
  vpc_id                  = aws_vpc.vpc_hml.id
  cidr_block              = "10.2.1.0/24"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "subnet-database-homolog_1-privado"
  }
  tags_all = {
    "Name" = "subnet-database-homolog_1-privado"
  }
}

resource "aws_subnet" "private_subnet_hml_2" {
  vpc_id                  = aws_vpc.vpc_hml.id
  cidr_block              = "10.2.2.0/24"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "subnet-application-homolog_2-privado"
  }
  tags_all = {
    "Name" = "subnet-application-homolog_2-privado"
  }
}

resource "aws_subnet" "private_subnet_hml_3" {
  vpc_id                  = aws_vpc.vpc_hml.id
  cidr_block              = "10.2.3.0/24"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "subnet-application-homolog_3-privado"
  }
  tags_all = {
    "Name" = "subnet-application-homolog_3-privado"
  }
}

## Security Group

resource "aws_security_group" "default-sg-hml" {
  description = "Security-Goup-SV-APP-HOMOLOG"
  name        = "SV-APP-HOMOLOG"
  vpc_id      = aws_vpc.vpc_hml.id
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description = ""
      from_port   = 0
      ipv6_cidr_blocks = [
        "::/0",
      ]
      prefix_list_ids = []
      protocol        = "-1"
      security_groups = []
      self            = false
      to_port         = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "10.2.0.0/16",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.2.0.0/16",
      ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks = [
        "10.2.0.0/16",
      ]
      description      = ""
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "10.2.0.0/16",
      ]
      description      = ""
      from_port        = 445
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 445
    },
    {
      cidr_blocks = [
        "10.2.0.0/16",
      ]
      description      = ""
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "udp"
      security_groups  = []
      self             = false
      to_port          = 53
    },
    {
      cidr_blocks = [
        "10.2.0.0/16",
      ]
      description      = ""
      from_port        = 7070
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 7070
    },
    {
      cidr_blocks = [
        "10.2.0.0/16",
      ]
      description      = ""
      from_port        = 8080
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 8080
    },
    {
      cidr_blocks = [
        "10.2.0.0/16",
      ]
      description      = ""
      from_port        = 9090
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 9090
    },
    {
      cidr_blocks = [
        "192.168.10.10/32",
        "187.33.127.224/27",
      ]
      description      = ""
      from_port        = -1
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = -1
    },
  ]
  tags = {
    "Name" = "SV-APP-HOMOLOG"
  }
  tags_all = {
    "Name" = "SV-APP-HOMOLOG"
  }
}

## VPC - PRD
resource "aws_vpc" "vpc_prod" {
  cidr_block                           = "10.1.0.0/16"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  assign_generated_ipv6_cidr_block     = true
  tags = {
    "Name" = "delcred-vpc-prod"
  }
  tags_all = {
    "Name" = "delcred-vpc-prod"
  }
}


## VPC Peering

resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = aws_vpc.vpc_hml.id
  auto_accept   = true
  tags = {
    "Name" = "vpc-peering-delcred"
  }
  tags_all = {
    "Name" = "vpc-peering-delcred"
  }
  vpc_id = aws_vpc.vpc_prod.id

  accepter {
    allow_remote_vpc_dns_resolution = false
  }

  requester {
    allow_remote_vpc_dns_resolution = false
  }
}