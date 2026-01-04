output "instance_name" {
    value = [aws_instance.myinstance[0].id, aws_instance.myinstance[1].id, aws_instance.myinstance[2].id]
}