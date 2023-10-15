#----------------------------------------------------------
# My Terraform
#
# Genarate Password
# Store Password in SSM Parameter Store
# Get Password from SSM Parameter Store
# Example of Use Password in RDS
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "ca-central-1"
}

// Generate Password
resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "!#$&"

  keepers = {
    kepeer1 = var.name
    //keperr2 = var.something
  }
}

// Store Password in SSM Parameter Store
resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/mysql"
  description = "Master Password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.rds_password.result
  tags = {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "f0c790fd-2c34-47b5-9051-8f0cb11242be"
  }
}

// Get Password from SSM Parameter Store
data "aws_ssm_parameter" "my_rds_password" {
  name       = "/prod/mysql"
  depends_on = [aws_ssm_parameter.rds_password]
}


// Example of Use Password in RDS
resource "aws_db_instance" "default" {
  identifier           = "prod-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "prod"
  username             = "administrator"
  password             = data.aws_ssm_parameter.my_rds_password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
  tags = {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "5f564eb1-b26f-42c5-ad8e-86b7929555c3"
  }
}
