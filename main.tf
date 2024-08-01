terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


locals {
  ingress_rules = [{
      port        = 443
      description = "Port 443"
    },
    {
      port        = 80
      description = "Port 80"
    }
  ]
}

resource "aws_vpc" "main" {
  cidr_block       = "10.22.31.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}


resource "aws_security_group" "main" {
  name   = "core-sg"
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    
  }
}