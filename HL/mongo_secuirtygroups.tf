####### security group Mongodb #######

resource "aws_security_group" "mongo_sg" {
  name   = "mongo_sg"
  vpc_id = "${aws_vpc.vpc_name.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  ingress {
  from_port   = -1
  to_port     = -1
  protocol = "icmp"
  cidr_blocks  = ["${var.vpc_cidr_block}"]
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Mongo_Security_Group"
  }
}
