#----------------------------------------------------------
# My Terraform
#
# Use Global Variables from Remote State
#
# Made by Denis Astahov
#----------------------------------------------------------

provider "aws" {
  region = "ca-central-1"
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "denis-astahov-project-kgb-terraform-state"
    key    = "globalvars/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {
  company_name = data.terraform_remote_state.global.outputs.company_name
  owner        = data.terraform_remote_state.global.outputs.owner
  common_tags  = data.terraform_remote_state.global.outputs.tags
}
#---------------------------------------------------------------------

resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name      = "Stack2-VPC1"
    Company   = local.company_name
    Owner     = local.owner
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "cfa889a6-3dd7-4c66-93b7-c710961cb51c"
  }
}


resource "aws_vpc" "vpc2" {
  cidr_block = "10.0.0.0/16"
  tags = merge(local.common_tags, { Name = "Stack2-VPC2" }, {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "22c519d2-13c2-4165-9091-27fa4b357e77"
  })
}
