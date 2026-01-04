resource "aws_instance" "myserver" {
    tags = {
        Name = "Terraform-ec2-server"
        Environment = "Dev"
        Cient = "TCS"
    }
    ami = "ami-068c0051b15cdb816"
    instance_type = "t3.micro"
    key_name = "docker_2.key" #select existing key pair
    availability_zone = "us-east-1a"
    root_block_device {
        volume_size = 10
    }
}