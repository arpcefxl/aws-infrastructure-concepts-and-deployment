resource "aws_eip" "ap-southeast-1-nat" {
  provider =  aws.ap-southeast-1
  count = 2
  vpc = true
}

module "ap-southeast-1-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.ap-southeast-1
  }
  name = "ap-southeast-1-demo-vpc"
  cidr = "10.3.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  azs = ["ap-southeast-1a", "ap-southeast-1b"]
  public_subnets = ["10.3.0.0/24", "10.3.1.0/24"]
  public_subnet_suffix = "public-subnet"
  private_subnets  = ["10.3.10.0/24", "10.3.11.0/24"]
  private_subnet_suffix = "private-subnet"
  enable_nat_gateway = true
  single_nat_gateway = false
  reuse_nat_ips = true
  external_nat_ip_ids = "${aws_eip.ap-southeast-1-nat.*.id}"
  tags = {
    Terraform = "true"
  }
}

resource "aws_eip" "eu-central-1-nat" {
  provider = aws.eu-central-1
  count = 2
  vpc = true
}

module "eu-central-1-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.eu-central-1
  }
  name = "eu-central-1-demo-vpc"
  cidr = "10.2.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  azs = ["eu-central-1a", "eu-central-1b"]
  public_subnets = ["10.2.0.0/24", "10.2.1.0/24"]
  public_subnet_suffix = "public-subnet"
  private_subnets  = ["10.2.10.0/24", "10.2.11.0/24"]
  private_subnet_suffix = "private-subnet"
  enable_nat_gateway = true
  single_nat_gateway = false
  reuse_nat_ips = true
  external_nat_ip_ids = "${aws_eip.eu-central-1-nat.*.id}"
  tags = {
    Terraform = "true"
  }
}

resource "aws_eip" "us-east-2-nat" {
  provider = aws.us-east-2
  count = 2
  vpc = true
}

module "us-east-2-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.us-east-2
  }
  name = "us-east-2-demo-vpc"
  cidr = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  azs = ["us-east-2a", "us-east-2b"]
  public_subnets = ["10.1.0.0/24", "10.1.1.0/24"]
  public_subnet_suffix = "public-subnet"
  private_subnets  = ["10.1.10.0/24", "10.1.11.0/24"]
  private_subnet_suffix = "private-subnet"
  enable_nat_gateway = true
  single_nat_gateway = false
  reuse_nat_ips = true
  external_nat_ip_ids = "${aws_eip.us-east-2-nat.*.id}"
  tags = {
    Terraform = "true"
  }
}
