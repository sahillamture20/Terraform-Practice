provider "aws" {
  region = "ap-south-1"
}

# Creating VPC with range 10.0.0.0/16
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name: "demo_vpc"
  }
}

# Creating public and private subnet in demo_vpc
resource "aws_subnet" "demo_public_sub" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "demo-public-sub"
  }
}

resource "aws_subnet" "demo_private_sub" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "demo-private-sub"
  }
}

# Creating internet gateway 
resource "aws_internet_gateway" "demo_vpc_igw" {
  vpc_id =  aws_vpc.demo_vpc.id
  tags = {
    Name = "demo-vpc-igw"
  }
}

# Creating public and private route table

resource "aws_route_table" "demo_public_rt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo-public-rt"
  }
}

resource "aws_route_table" "demo_private_rt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo-private-rt"
  }
}

# Associate route tables with subnet
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.demo_public_sub.id
  route_table_id = aws_route_table.demo_public_rt.id
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.demo_private_sub.id
  route_table_id = aws_route_table.demo_private_rt.id
}

# Add routes in the public route table for the intetnet gateway
resource "aws_route" "public_igw_rule" {
  route_table_id = aws_route_table.demo_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.demo_vpc_igw.id
}