# Up to Terraform v0.15.1
# terraform taint aws_instance.node2
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
    yor_trace = "8871b30b-98ac-4478-a38d-e025983f2712"
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
    yor_trace = "a2f10c09-b2ea-4ee2-ba69-2a05bf61f865"
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
    yor_trace = "7a6f1edb-1a60-4e9a-9e84-9227f25556b5"
  }
  depends_on = [aws_instance.node2]
}
