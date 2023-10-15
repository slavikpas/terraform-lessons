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
    Name      = "Stack1-VPC1"
    Company   = local.company_name
    Owner     = local.owner
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "33d41ba2-bc46-44dc-98a4-7c644b15c902"
  }
}


resource "aws_vpc" "vpc2" {
  cidr_block = "10.0.0.0/16"
  tags = merge(local.common_tags, { Name = "Stack1-VPC2" }, {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "917128b6-d920-435a-a039-79aeff344b84"
  })
}
