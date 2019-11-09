provider "aws" {
  alias = "region"
}

#resource aws_cloudformation_stack "demo-vpc1" {
#  name = "demo-vpc1"
#  template_body = "${file("./us-west-2/demo-vpc1.yaml")}"
#  provider = "aws.region"
#}

#resource aws_cloudformation_stack "demo-vpc2" {
#  name = "demo-vpc2"
#  template_body = "${file("./us-west-2/demo-vpc2.yaml")}"
#  provider = "aws.region"
#}

resource "aws_vpc" "vpc1" {
  cidr_block = "${var.cidr1_vpc}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags {
    Environment = "${var.environment1_tag}"
  }
  provider = "aws.region"
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = "${aws_vpc.vpc1.id}"
  tags {
    "Environment" = "${var.environment1_tag}"
  }
  provider = "aws.region"
}

resource "aws_subnet" "subnet1_public" {
  vpc_id = "${aws_vpc.vpc1.id}"
  cidr_block = "${var.cidr1_subnet}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.availability_zone}"
  tags {
    "Environment" = "${var.environment1_tag}"
  }
  provider = "aws.region"
}

resource "aws_route_table" "rtb1_public" {
  vpc_id = "${aws_vpc.vpc1.id}"
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw1.id}"
  }
tags {
    "Environment" = "${var.environment1_tag}"
  }
  provider = "aws.region"
}

resource "aws_route_table_association" "rta_subnet1_public" {
  subnet_id      = "${aws_subnet.subnet1_public.id}"
  route_table_id = "${aws_route_table.rtb1_public.id}"
  provider = "aws.region"
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
  tags {
    "Environment" = "${var.environment1_tag}"
  }
  provider = "aws.region"
}
