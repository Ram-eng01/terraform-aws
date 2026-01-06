resource "aws_instance" "myinstance" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t3.micro" 
    availability_zone = "us-east-1a"
    key_name = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    root_block_device {
        volume_size = 10
    }

    tags = {
      Name = "My-server"
    }

    provisioner "local-exec" {
      command = "echo 'Instance created with an ID: ${aws_instance.myinstance.id}' >> server-id.txt"
    }
    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
      private_key = file("C:/Users/rammo/.ssh/id_ed25519")
    }

    provisioner "remote-exec" {
      inline = [ 
            "echo 'This command is executing on remote server'",
            "sudo yum install httpd -y",
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd",
            "sudo yum install git -y"

       ]
    }
    provisioner "file" {
      source = "C:/Users/rammo/OneDrive/Desktop/FLM_DevOPS/terraform-aws/11-provisioners/provider.tf"
      destination = "/home/ec2-user/provider.tf"
    }
}


resource "aws_key_pair" "mykey" {
  key_name = "flm"
  public_key = file("C:/Users/rammo/.ssh/id_ed25519.pub")
}


resource "aws_security_group" "my_sg" {
  name = "Terraform sg"
  description = "created by terraform"

  dynamic "ingress" {
    for_each = toset(var.ports)
    content {
      protocol = "tcp"
      from_port = ingress.value
      to_port = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}