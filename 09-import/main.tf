resource "aws_instance" "myinstance" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t2.micro"
    tags = {
      Name = "terraform-instance"
    }
    # lifecycle {
    #   create_before_destroy = true
    # }

    # lifecycle {
    #   ignore_changes = [ instance_type, tags ]
    # }

    lifecycle {
      prevent_destroy = false
    }
}

import {
  to = aws_instance.myinstance
  id = "i-078fede1e2a6332de"
}
