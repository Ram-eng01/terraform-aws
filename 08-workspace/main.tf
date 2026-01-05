resource "aws_instance" "myinstance" {
   tags = {
     Name = "${terraform.workspace}-server"
   }
   ami = "ami-068c0051b15cdb816"
   instance_type = local.instance_types[terraform.workspace]
   key_name = "docker_2.key"
}


# terraform workspace list
# terraform workspace new prod
# terraform workspace show
# terraform workspace select default
