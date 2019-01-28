resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"

  tags = {
    "Name" = "Terraform VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    "Name" = "Terraform Main IGW"
  }
}
