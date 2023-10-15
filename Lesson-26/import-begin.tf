# terraform import aws_instance.node1 i-0417da3dfcfd6e059
# terraform import aws_instance.node2 i-0b92baf1fa014b3e2
# terraform import aws_instance.node3 i-0ca6e4b3d52437673
# terraform import aws_security_group.nomad sg-0bb76870a0cbc887a

resource "aws_instance" "node1" {

  tags = {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "c5925e49-4581-4221-afd8-220d0ed8fd46"
  }
}

resource "aws_instance" "node2" {

  tags = {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "6da08596-579b-4bc1-9e1f-6a8e48f279ff"
  }
}

resource "aws_instance" "node3" {

  tags = {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "08d65d0f-5fec-4b5d-b980-bdff5ae99c9a"
  }
}

resource "aws_security_group" "nomad" {

  tags = {
    git_org   = "slavikpas"
    git_repo  = "terraform-lessons"
    yor_trace = "d3f022e0-f1f5-4557-b1ca-5a3439891116"
  }
}
