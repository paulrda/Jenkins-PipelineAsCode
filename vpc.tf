resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "zaf-aws-vpc"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

/*
  Public Subnet
*/
resource "aws_subnet" "eu-west-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "eu-west-1a"

    tags {
        Name = "ZAF Public Subnet"
    }
}

resource "aws_route_table" "eu-west-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "eu-west-1a-public" {
    subnet_id = "${aws_subnet.eu-west-1a-public.id}"
    route_table_id = "${aws_route_table.eu-west-1a-public.id}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "eu-west-1a-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "eu-west-1a"

    tags {
        Name = "Private Subnet"
    }
}

/*
  This subnet is here only because RDS needs 2 AZ regardless
*/
resource "aws_subnet" "eu-west-1b-useless" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.useless_subnet_cidr}"
    availability_zone = "eu-west-1b"

    tags {
        Name = "Useless Subnet"
    }
}

