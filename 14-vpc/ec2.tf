# resource "aws_instance" "my-public-instance" {
#     tags = {
#       Name = "public-server"
#     }
#     ami = "ami-068c0051b15cdb816"
#     instance_type = "t3.micro"
#     key_name = "docker_2.key" #select existing key pair
    
#     availability_zone = "us-east-1a"
#     root_block_device {
#         volume_size = 10
#     }
# }