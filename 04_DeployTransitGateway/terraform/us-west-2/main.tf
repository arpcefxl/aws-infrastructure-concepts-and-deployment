provider "aws" {
  alias = "region"
}

resource aws_cloudformation_stack "demo-vpc1" {
  name = "demo-vpc1"
  template_body = "${file("./us-west-2/demo-vpc1.yaml")}"
  provider = "aws.region"
}

resource aws_cloudformation_stack "demo-vpc2" {
  name = "demo-vpc2"
  template_body = "${file("./us-west-2/demo-vpc2.yaml")}"
  provider = "aws.region"
}

