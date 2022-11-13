####### security group Mongodb #######

resource "aws_security_group" "mongo_sg" {
  name   = "mongo_sg"
  vpc_id = "${aws_vpc.vpc_name.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_group_id = ["${aws_security_group.vpn_sg.id}", "${aws_security_group.application_sg.id}"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_group_id = ["${aws_security_group.vpn_sg.id}", "${aws_security_group.application_sg.id}"]
  }

  ingress {
  from_port   = -1
  to_port     = -1
  protocol = "icmp"
  security_group_id = ["${aws_security_group.vpn_sg.id}", "${aws_security_group.application_sg.id}"]
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_group_id = ["${aws_security_group.vpn_sg.id}", "${aws_security_group.application_sg.id}"]
  }

  tags = {
    Name = "Mongo_Security_Group"
  }
}
