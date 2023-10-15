#----------------------------------------------------------
# My Terraform
# Provision:
#  - VPC
#  - Internet Gateway
#  - XX Public Subnets
#  - XX Private Subnets
#  - XX NAT Gateways in Public Subnets to give access to Internet from Private Subnets
#
# Made by Denis Astahov. Summer 2019
#----------------------------------------------------------

#==============================================================

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name      = "${var.env}-vpc"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "58554432-3a25-4d97-83c6-9cb6f49a65db"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name      = "${var.env}-igw"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "518d1e21-1356-44fb-bd78-74af888de810"
  }
}

#-------------Public Subnets and Routing----------------------------------------
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name      = "${var.env}-public-${count.index + 1}"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "2d8b23c7-d154-429f-bc7e-046b59a70d29"
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
    yor_trace = "e4bed7d6-7338-4a23-a20d-489c8a2597ed"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}


#-----NAT Gateways with Elastic IPs--------------------------


resource "aws_eip" "nat" {
  count = length(var.private_subnet_cidrs)
  vpc   = true
  tags = {
    Name      = "${var.env}-nat-gw-${count.index + 1}"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "b1171996-a9f0-4b3b-8cab-e04498f5a498"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.private_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  tags = {
    Name      = "${var.env}-nat-gw-${count.index + 1}"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "42378992-e70f-4373-bd58-573be9ad3c4b"
  }
}


#--------------Private Subnets and Routing-------------------------

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name      = "${var.env}-private-${count.index + 1}"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "1a937ced-61bf-4ebc-b01a-d1cec13c69af"
  }
}

resource "aws_route_table" "private_subnets" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
    Name      = "${var.env}-route-private-subnet-${count.index + 1}"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "7a0275fe-f15a-4f2d-9cd2-4434da2e5ec7"
  }
}

resource "aws_route_table_association" "private_routes" {
  count          = length(aws_subnet.private_subnets[*].id)
  route_table_id = aws_route_table.private_subnets[count.index].id
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
}

#==============================================================
