variable "iname" {
  type = list(string)
  default = [ "server-1","server-2","server-3" ]
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

