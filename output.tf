output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}

output "public_cidrs" {
  value = "${aws_subnet.public.*.cidr_block}"
}

output "application_subnets" {
  value = "${aws_subnet.application.*.id}"
}

output "application_cidrs" {
  value = "${aws_subnet.application.*.cidr_block}"
}
output "database_subnets" {
  value = "${aws_subnet.database.*.id}"
}

output "database_cidrs" {
  value = "${aws_subnet.database.*.cidr_block}"
}
