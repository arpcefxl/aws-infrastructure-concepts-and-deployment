#simple Terraform template to deploy VPCs simultaneously to 3 regions

module "us-east-2_cloudformation" {
  source = "./us-east-2"
  providers = {
    "aws.region" = "aws.us-east-2"
  }
  
}

module "ap-southeast-1_cloudformation" {
  source = "./ap-southeast-1"
  providers = {
    "aws.region" = "aws.ap-southeast-1"
  }
  
}

module "eu-central-1_cloudformation" {
  source = "./eu-central-1"
  providers = {
    "aws.region" = "aws.eu-central-1"
  }
  
}

