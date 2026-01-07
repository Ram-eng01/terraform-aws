resource "aws_vpc" "myvpc" {
  tags = {
    Name = "Terraform-vpc"
  }
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
}


resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "Public-Subnet-1"
  }
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
}


resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "Private-Subnet-2"
  }
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.1.0/24"

}


resource "aws_internet_gateway" "my_IGW" {
  tags = {
    Name = "Terraform-IGW"
  }
  vpc_id = aws_vpc.myvpc.id
}


resource "aws_route_table" "public_rt" {
  tags = {
    Name = "public-rt"
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_IGW.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "myeip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "mynat" {
  tags = {
    Name = "Terraform-NAT"
  }
  subnet_id         = aws_subnet.public_subnet.id
  connectivity_type = "public"
  allocation_id     = aws_eip.myeip.id

}
resource "aws_route_table" "private_rt" {
  tags = {
    Name = "private-rt"
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat.id
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}