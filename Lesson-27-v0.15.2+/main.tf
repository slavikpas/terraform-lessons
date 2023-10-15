# Since Terraform v0.15.2
# terraform apply -replace aws_instance.node2
#
provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "node1" {
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name      = "Node-1"
    Owner     = "Denis Astahov"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "2e9d98d0-af7d-4f5d-b3e3-4d2beecac2f6"
  }
}

resource "aws_instance" "node2" {
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name      = "Node-2"
    Owner     = "Denis Astahov"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "a7f9671a-f93e-4131-8a3e-ec77d5f3c402"
  }
}

resource "aws_instance" "node3" {
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name      = "Node-3"
    Owner     = "Denis Astahov"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "edd7ef00-e7f6-4d79-942c-678e0bcfeba2"
  }
  depends_on = [aws_instance.node2]
}
