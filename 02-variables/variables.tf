variable "ec2_tags" {
  type = map(any)
  default = {
    Name      = "terraform-server"
    Env       = "prod"
    Terraform = "true"
  }

}

variable "icount" {
  type    = number
  default = 3

}
variable "ami_id" {
  type    = string
  default = "ami-068c0051b15cdb816"
}
variable "itype" {
  type    = string
  default = "t3.micro"

}

variable "isize" {
  type    = number
  default = 10
}