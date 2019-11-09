#simple Terraform template to deploy 2 VPCs and EC2 in the same region

module "us-west-2_vpc_ec2" {
  source = "./us-west-2"
  providers = {
    "aws.region" = "aws.us-west-2"
  }
  
}

