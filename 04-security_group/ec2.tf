resource "aws_instance" "myserver" {
    tags = {
        Name = "Terraform-ec-server"
        Environment = "Dev"
        Cient = "TCS"
    }
    ami = "ami-068c0051b15cdb816"
    instance_type = "t3.micro"
    key_name = "docker_2.key" #select existing key pair
    vpc_security_group_ids = [aws_security_group.mysecurity.id]
    root_block_device {
        volume_size = 10
    }
}