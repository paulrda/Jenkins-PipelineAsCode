/*
  Web Servers
*/
resource "aws_security_group" "alfresco" {
    name = "vpc_alfresco"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8443
        to_port = 8443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress { # MySQL
 	from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "AlfrescoSG"
    }
}



resource "aws_instance" "alfresco-1" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "eu-west-1a"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.alfresco.id}"]
    subnet_id = "${aws_subnet.eu-west-1a-public.id}"
    associate_public_ip_address = false
    source_dest_check = false


    tags {
        Name = "Alfresco1"
    }
}
