resource "aws_instance" "task_instance" {
   for_each = toset(var.iname)
   ami = "ami-068c0051b15cdb816"
   instance_type = var.instance_type
   key_name = "docker_2.key"
   root_block_device {
     volume_size = 10
   }

   tags = {
     Name = each.key
     Environment = "Dev"
   }
}


