resource "aws_instance" "task_instance" {
   tags = {
     Name = var.iname[count.index]
     Environment = "Dev"
   }
   count = 3
   ami = "ami-068c0051b15cdb816"
   instance_type = var.instance_type[count.index]
   availability_zone = var.availability_zone[count.index]
   key_name = "docker_2.key"
   root_block_device {
     volume_size = 10
   }
}