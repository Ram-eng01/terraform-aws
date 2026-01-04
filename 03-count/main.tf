resource "aws_instance" "myinstance" {
  tags = {
    Name = var.iname[count.index] 
    Environment = "Dev"
    Client = "TCS"
  }
  ami = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  key_name = "docker_2.key"
  count = var.icount

}
