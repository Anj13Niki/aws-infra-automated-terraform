resource "aws_vpc" "myautomatedvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "automated_subnet1" {
    vpc_id = aws_vpc.myautomatedvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "automated_subnet2" {
    vpc_id = aws_vpc.myautomatedvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1b"
    map_public_ip_on_launch = true
}

#internet gateway

resource "aws_internet_gateway" "automatedigw" {
  vpc_id = aws_vpc.myautomatedvpc.id
}

resource "aws_route_table" "automatedRT" {
  vpc_id = aws_vpc.myautomatedvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.automatedigw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.automated_subnet1.id
  route_table_id = aws_route_table.automatedRT.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.automated_subnet2.id
  route_table_id = aws_route_table.automatedRT.id
}