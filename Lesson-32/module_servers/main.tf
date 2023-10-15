terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.root,
        aws.prod,
        aws.dev
      ]
    }
  }
}
#----------------------------------------------
data "aws_ami" "latest_ubuntu20_root" {
  provider    = aws.root
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_ubuntu20_prod" {
  provider    = aws.prod
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_ubuntu20_dev" {
  provider    = aws.dev
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


#-------------------------------------------------------------------
resource "aws_instance" "server_root" {
  provider      = aws.root
  ami           = data.aws_ami.latest_ubuntu20_root.id
  instance_type = var.instance_type
  tags = { Name = "Server-ROOT"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "9db5a6e8-ea8f-4952-a1a2-7d95bcac5902"
  }
}

resource "aws_instance" "server_prod" {
  provider      = aws.prod
  ami           = data.aws_ami.latest_ubuntu20_prod.id
  instance_type = var.instance_type
  tags = { Name = "Server-PROD"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "77d9b7a2-e6f0-4520-a88d-f901a3d52954"
  }
}

resource "aws_instance" "server_dev" {
  provider      = aws.dev
  ami           = data.aws_ami.latest_ubuntu20_dev.id
  instance_type = var.instance_type
  tags = { Name = "Server-DEV"
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "a7fafef0-3f69-4a40-8a72-596204b23239"
  }
}
