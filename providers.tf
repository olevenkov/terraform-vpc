provider "aws" {
  region = "${var.region}"
  version = "1.31"
  }
provider "template" {
  version = "2.0.0"
  }
terraform {
  required_version = ">= 0.11.7"
  }
