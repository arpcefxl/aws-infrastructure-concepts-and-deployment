variable "cidr1_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "cidr1_subnet" {
  description = "CIDR block for the subnet"
  default = "10.1.0.0/24"
}
variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "us-west-2a"
}
variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}

variable "cidr2_vpc" {
  description = "CIDR block for the VPC"
  default = "10.2.0.0/16"
}
variable "cidr2_subnet" {
  description = "CIDR block for the subnet"
  default = "10.2.0.0/24"
}
