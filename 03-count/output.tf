output "myoutput" {
  value = [aws_instance.myinstance[0].public_ip, aws_instance.myinstance[1].private_ip, aws_instance.myinstance[2].public_dns]
}