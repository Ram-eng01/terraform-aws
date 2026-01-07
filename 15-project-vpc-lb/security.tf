resource "aws_security_group" "my_sg" {
  name        = "Terraform-SG"
  description = "This is created by terraform"
  vpc_id      = aws_vpc.myvpc.id


  dynamic "ingress" {
    for_each = toset(var.ports)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}