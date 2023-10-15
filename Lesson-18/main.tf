#----------------------------------------------------------
# My Terraform
#
# Terraform Loops: Count and For if
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "ca-central-1"
}


resource "aws_iam_user" "user1" {
  name = "pushkin"
  tags = {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "a84f2ce0-53e7-45e0-ab28-46e937696dd4"
  }
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
  tags = {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "75c8cb42-fa8b-40d5-bf65-de08ecb60a09"
  }
}

#----------------------------------------------------------------

resource "aws_instance" "servers" {
  count         = 3
  ami           = "ami-07ab3281411d31d04"
  instance_type = "t3.micro"
  tags = {
    Name      = "Server Number ${count.index + 1}"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "0867bae7-1c64-4566-9692-5f33084af44e"
  }
}
