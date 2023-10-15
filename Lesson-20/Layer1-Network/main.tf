#----------------------------------------------------------
# My Terraform
#
# Remote State on S3
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "ca-central-1"
}

terraform {
  backend "s3" {
    bucket = "denis-astahov-project-kgb-terraform-state" // Bucket where to SAVE Terraform State
    key    = "dev/network/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}

#==============================================================

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name      = "${var.env}-vpc"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "cb33cddb-4085-4db1-ad95-da5ff73f8e68"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name      = "${var.env}-igw"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "359ac250-c0e0-4d85-a79b-850fb6fee54a"
  }
}


resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name      = "${var.env}-puvlic-${count.index + 1}"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "83540fec-6299-48ce-8478-0ede132581fd"
  }
}


resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name      = "${var.env}-route-public-subnets"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "a2b9b24c-6e53-4423-88d0-2843f2a7d52c"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}

#==============================================================
