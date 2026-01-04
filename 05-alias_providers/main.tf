resource "aws_instance" "myserver-us" {
    tags = {
        Name = "Terraform-us-server"
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

resource "aws_instance" "myserver-ap" {
    provider = aws.mumbai
    tags = {
        Name = "Terraform-ap-server"
        Environment = "Dev"
        Cient = "TCS"
    }
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t3.micro"
    root_block_device {
        volume_size = 10
    }
}