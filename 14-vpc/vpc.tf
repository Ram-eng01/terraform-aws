resource "aws_vpc" "myvpc" {
    tags = {
      Name = "Terraform-VPC"
      ENV = "Dev"
    }

    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "Terraform-Public-Subnet"
  }
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "Terraform-Private-Subnet"
  }
  availability_zone = "us-east-1a"
  cidr_block = "10.0.2.0/24"
}

resource "aws_internet_gateway" "mgigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "Terraform-IGW"
  }
}

resource "aws_route_table" "public-rt" {
  tags = {
    Name = "Terarform-Public-RT"
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mgigw.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_eip" "myeip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "mynat" {
    tags = {
      Name = "Terraform-NAT"
    }
    subnet_id = aws_subnet.public-subnet.id
    connectivity_type = "public"
    allocation_id = aws_eip.myeip.id
  
}


resource "aws_route_table" "private-rt" {
  tags = {
    Name = "Terarform-private-RT"
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat.id
  }
}


resource "aws_route_table_association" "privat_association" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}