# variable "ports" {
#     default = ["22","80","8080","8081","9000","5000"]
# }


variable "allow_ports" {
   default = [
    {
        from_port = 22
        to_port = 22
    },
    {
        from_port = 8080
        to_port = 8080
    },
    {
        from_port = 80
        to_port = 80
    }

   ]
}