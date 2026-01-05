resource "aws_security_group" "dynamic_sg" {
  name = "dynamic-security-group"
  description = "This is created by using terraform"

  dynamic "ingress" {
    for_each = toset(var.ports)
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}