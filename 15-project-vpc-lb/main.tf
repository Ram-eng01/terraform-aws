resource "aws_launch_template" "mylt" {
  name          = "Terraform-LT"
  description   = "This is created by terraform"
  image_id      = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  key_name      = "docker_2.key"
  placement {
    availability_zone = "us-east-1a"
  }
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "MyServer"
  }
}



resource "aws_elb" "myelb" {
  name            = "Terarform-lb"
  subnets         = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
  security_groups = [aws_security_group.my_sg.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  tags = {
    Name = "Terraform-LB"
  }
}


resource "aws_autoscaling_group" "myasg" {
  name = "Terraform-ASG"
  launch_template {
    id = aws_launch_template.mylt.id
  }
  max_size            = 4
  min_size            = 1
  desired_capacity    = 2
  health_check_type   = "EC2"
  load_balancers      = [aws_elb.myelb.name]
  vpc_zone_identifier = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
}