variable "iname" {
  type = list(string)
  default = [ "server-1","server-2","server-3" ]
}

variable "instance_type" {
  type = list(string)
  default = ["t3.micro","t2.micro","t2.medium"]
}

variable "availability_zone" {
  type = list(string)
  default = [ "us-east-1a","us-east-1b","us-east-1c" ]
}