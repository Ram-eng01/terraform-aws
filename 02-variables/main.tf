resource "aws_instance" "myinstance" {
  tags          = var.ec2_tags
  ami           = var.ami_id
  instance_type = var.itype
  count         = var.icount
  root_block_device {
    volume_size = var.isize
  }
}
