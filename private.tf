
resource "aws_security_group" "db" {
    name = "vpc_private"
    description = "Allow incoming database connections."
    ingress { # RDS Maria DB
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
	security_groups = ["${aws_security_group.alfresco.id}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "Database security group"
    }
}

resource "aws_db_subnet_group" "default" {
    name = "dbsubnetgroup"
    subnet_ids = ["${aws_subnet.eu-west-1a-private.id}","${aws_subnet.eu-west-1b-useless.id}"]
    tags {
        Name = "My DB subnet group"
    }
}


resource "aws_db_instance" "mariadb-1" {
  allocated_storage    = 10
  engine               = "mariadb"
  engine_version       = "10.0.24"
  instance_class       = "db.t2.micro"
  name                 = "alfresco"
  username             = "alfresco"
  password             = "alfresco"
  multi_az = false
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
  vpc_security_group_ids = ["${aws_security_group.db.id}"]	
}

resource "aws_s3_bucket" "alfrescoContentStore" {
    bucket = "alfresco.content.store"
    acl = "private"

    tags {
        Name = "contentStore"
        Environment = "Dev"
    }
}
