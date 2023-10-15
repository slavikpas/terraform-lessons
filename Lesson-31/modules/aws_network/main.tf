#----------------------------------------------------------
# My Terraform
# Provision:
#  - VPC
#  - Internet Gateway

# Made by Denis Astahov. Summer 2020
#----------------------------------------------------------

#==============================================================

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name      = "${var.env}-vpc"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "169b59c4-e6a9-40c5-93f6-2c3601a77374"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name      = "${var.env}-igw"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "75249c19-b063-4cbe-b49b-e52717f92fd8"
  }
}
