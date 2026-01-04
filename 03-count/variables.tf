variable "iname" {
  type = list(string)
  default = [ "server-1", "server-2","server-3" ]
}

variable "icount" {
  type = number
  default = 3
}