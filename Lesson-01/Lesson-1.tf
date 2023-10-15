provider "aws" {}


resource "aws_instance" "my_Ubuntu" {
  ami           = "ami-090f10efc254eaf55"
  instance_type = "t3.micro"

  tags = {
    Name      = "My Ubuntu Server"
    Owner     = "Denis Astahov"
    Project   = "Terraform Lessons"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "312a8ff8-f75d-45d4-ad11-0d80650205a8"
  }
}

resource "aws_instance" "my_Amazon" {
  ami           = "ami-03a71cec707bfc3d7"
  instance_type = "t3.small"

  tags = {
    Name      = "My Amazon Server"
    Owner     = "Denis Astahov"
    Project   = "Terraform Lessons"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "5a7dac70-bc6c-4bd0-a9eb-96e5e4c0e651"
  }
}
