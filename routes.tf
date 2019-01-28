resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    "Name" = "Public route table"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table_association" "public" {
  count = "${length(var.availability_zones)}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table" "application" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    "Name" = "Application route table - ${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route_table" "database" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    "Name" = "Database route table - ${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route" "application_gateway" {
  count = "${length(var.availability_zones)}"

  route_table_id         = "${element(aws_route_table.application.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}
resource "aws_route" "database_gateway" {
  count = "${length(var.availability_zones)}"

  route_table_id         = "${element(aws_route_table.database.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}

resource "aws_route_table_association" "application" {
  count = "${length(var.availability_zones)}"

  subnet_id      = "${element(aws_subnet.application.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.application.*.id, count.index)}"
}
resource "aws_route_table_association" "database" {
  count = "${length(var.availability_zones)}"

  subnet_id      = "${element(aws_subnet.database.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.database.*.id, count.index)}"
