#simple Terraform template to deploy VPCs simultaneously to 3 regions

module "us-west-2_cloudformation" {
  source = "./us-west-2"
  providers = {
    "aws.region" = "aws.us-west-2"
  }
  
}

