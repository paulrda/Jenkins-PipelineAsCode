# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name        = "zaf_elb_SG"
  description = "ZAF ELB security group"
  vpc_id      = "${aws_vpc.default.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Create a new load balancer
resource "aws_elb" "zafelb" {
  name = "zaf-elb"
  subnets         = ["${aws_subnet.eu-west-1a-public.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
  instances       = ["${aws_instance.alfresco-1.id}"]  

  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  tags {
    Name = "zaf-elb"
  }
}
