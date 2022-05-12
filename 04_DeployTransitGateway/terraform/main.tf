provider "aws" {
  region  = "us-west-2"
}

resource "aws_vpc" "vpc1" {
  cidr_block = "${var.cidr1_vpc}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc1"
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = "${aws_vpc.vpc1.id}"
  tags = {
    Name = "vpc1"
  }
}

resource "aws_subnet" "subnet1_public" {
  vpc_id = "${aws_vpc.vpc1.id}"
  cidr_block = "${var.cidr1_subnet}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.availability_zone}"
  tags = {
    Name = "vpc1"
  }
}

resource "aws_route_table" "rtb1_public" {
  vpc_id = "${aws_vpc.vpc1.id}"
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw1.id}"
  }
  tags = {
    Name = "vpc1"
  }
}

resource "aws_route_table_association" "rta_subnet1_public" {
  subnet_id      = "${aws_subnet.subnet1_public.id}"
  route_table_id = "${aws_route_table.rtb1_public.id}"
}

resource "aws_security_group" "ssh_from_home1" {
  name = "ssh_from_home"
  vpc_id = "${aws_vpc.vpc1.id}"
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["208.76.0.0/22"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh_from_home1"
  }
}

resource "aws_instance" "test1" {
  ami           = "${data.aws_ami.amazonlinux2.id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${aws_subnet.subnet1_public.id}"
  vpc_security_group_ids = ["${aws_security_group.ssh_from_home1.id}"]
  key_name = "csmithaws"
  tags = {
    Name = "vpc1",
    costcenter = "demo"
  }
}
resource "aws_vpc" "vpc2" {
  cidr_block = "${var.cidr2_vpc}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc2"
  }
}

resource "aws_internet_gateway" "igw2" {
  vpc_id = "${aws_vpc.vpc2.id}"
  tags = {
    Name = "vpc2"
  }
}

resource "aws_subnet" "subnet2_public" {
  vpc_id = "${aws_vpc.vpc2.id}"
  cidr_block = "${var.cidr2_subnet}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.availability_zone}"
  tags = {
    Name = "vpc2"
  }
}

resource "aws_route_table" "rtb2_public" {
  vpc_id = "${aws_vpc.vpc2.id}"
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw2.id}"
  }
  tags = {
    Name = "vpc2"
  }
}

resource "aws_route_table_association" "rta_subnet2_public" {
  subnet_id      = "${aws_subnet.subnet2_public.id}"
  route_table_id = "${aws_route_table.rtb2_public.id}"
}

resource "aws_security_group" "ssh_from_home2" {
  name = "ssh_from_home"
  vpc_id = "${aws_vpc.vpc2.id}"
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["208.76.0.0/22"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh_from_home2"
  }
}

resource "aws_instance" "test2" {
  ami           = "${data.aws_ami.amazonlinux2.id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${aws_subnet.subnet2_public.id}"
  vpc_security_group_ids = ["${aws_security_group.ssh_from_home2.id}"]
  key_name = "csmithaws"
  tags = {
    Name = "vpc2",
    costcenter = "demo"
  }
}
