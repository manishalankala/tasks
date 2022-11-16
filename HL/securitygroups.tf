# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule

# resource "aws_security_group"
# resource "aws_security_group_rule"


#-------------------------------------
# VPN - Security_Group & Rules
#-------------------------------------

resource "aws_security_group" "vpn_sg" {
  vpc_id = "vpc"
  name   = "vpn_sg"

resource "aws_security_group_rule" "vpn_ingress_443" {
  security_group_id = "${aws_security_group.vpn_sg.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_1"]
}

resource "aws_security_group_rule" "vpn_ingress_943" {
  security_group_id = "${aws_security_group.vpn_sg.id}"
  type = "ingress"
  from_port = 943
  to_port = 943
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_1"]
}

resource "aws_security_group_rule" "vpn_ingress_1194" {
  security_group_id = "${aws_security_group.vpn_sg.id}"
  type = "ingress"
  from_port = 1194
  to_port = 1194
  protocol = "udp"
  cidr_blocks = ["${var.vpc_public_subnet_1"]
}


resource "aws_security_group_rule" "vpn_egress_all" {
  security_group_id = "${aws_security_group.vpn_sg.id}"
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}





alb_external_sg

alb_internal_sg

  resource "aws_security_group" "vpn_sg" {
  vpc_id = "vpc"
  name   = "vpn_sg"


resource "aws_security_group" "alb_external_sg" {
    name = "nginx_sg"
    vpc_id  = aws_vpc.vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_group_id = "${aws_security_group.vpn_sg.id}"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_group_id = "${aws_security_group.vpn_sg.id}"
    }
}


  
  
  
  
resource "aws_security_group" "mongodb_sg" {
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${ }"]
  }
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["${ }"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${}"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${}"]
  }
  egress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["${ }"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${ }"]
  }


    
}
