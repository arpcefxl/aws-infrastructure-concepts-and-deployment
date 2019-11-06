provider "aws" {
  alias = "region"
}

resource aws_cloudformation_stack "demo-vpc" {
  name = "us-east-2"
  template_body = "${file("./us-east-2/demo-vpc-us-east-2.yaml")}"
  provider = "aws.region"
  tags {
    CostCenter = "demo"
  }
}

