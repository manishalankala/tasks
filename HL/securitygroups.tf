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


  
#-------------------------------------
# Alb_External - Security_Group & Rules
#-------------------------------------  

resource "aws_security_group" "alb_external_sg" {
  vpc_id = "vpc"
  name   = "alb_external_sg"

resource "aws_security_group_rule" "alb_external_ingress_80" {
  security_group_id = "${aws_security_group.alb_external_sg.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_2}","${var.vpc_public_subnet_3}"]
}

resource "aws_security_group_rule" "alb_external_ingress_8080" {
  security_group_id = "${aws_security_group.alb_external_sg.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_3}","${var.vpc_public_subnet_4}"]
}

resource "aws_security_group_rule" "alb_external_ingress_443" {
  security_group_id = "${aws_security_group.alb_external_sg.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_3}","${var.vpc_public_subnet_4}"]
}

resource "aws_security_group_rule" "alb_external_egress_all" {
  security_group_id = "${aws_security_group.alb_external_sg.id}"
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["${var.vpc_public_subnet_3}","${var.vpc_public_subnet_4}"]
}
  
 

#-------------------------------------
# Alb_Internal - Security_Group & Rules
#-------------------------------------  

resource "aws_security_group" "alb_internal_sg" {
  vpc_id = "vpc"
  name   = "alb_internal_sg"

resource "aws_security_group_rule" "alb_internal_ingress_80" {
  security_group_id = "${aws_security_group.alb_internal.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_3}","${var.vpc_public_subnet_4}"]
}


resource "aws_security_group_rule" "alb_internal_ingress_3000" {
  security_group_id = "${aws_security_group.alb_external_sg.id}"
  type = "ingress"
  from_port = 3000
  to_port = 3000
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_3}","${var.vpc_public_subnet_4}"]
}

resource "aws_security_group_rule" "alb_internal_ingress_443" {
  security_group_id = "${aws_security_group.alb_external_sg.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_3}","${var.vpc_public_subnet_4}"]
}

resource "aws_security_group_rule" "alb_internal_egress_all" {
  security_group_id = "${aws_security_group.alb_internal_sg.id}"
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["${var.vpc_public_subnet_3}","${var.vpc_public_subnet_4}"]
}

  
#-------------------------------------
# App instances - Security_Group & Rules
#-------------------------------------  

resource "aws_security_group" "app_sg" {
  vpc_id = "vpc"
  name   = "app_sg"

resource "aws_security_group_rule" "app_ingress_3000" {
  security_group_id = "${aws_security_group.app_sg.id}"
  type = "ingress"
  from_port = 3000
  to_port = 3000
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_5}","${var.vpc_public_subnet_6}"]
}
 
resource "aws_security_group_rule" "app_ingress_22" {
  security_group_id = "${aws_security_group.app_sg.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_5}","${var.vpc_public_subnet_6}"]
} 
  
resource "aws_security_group_rule" "egress_all" {
  security_group_id = "${aws_security_group.app_sg.id}"
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_public_subnet_5}","${var.vpc_public_subnet_6}","${var.vpc_private_subnet_7}","${var.vpc_public_subnet_8}","${var.vpc_private_subnet_9}"]
}

  
  

#-------------------------------------
# Mongodb - Security_Group & Rules
#-------------------------------------  
  
resource "aws_security_group" "mongo_sg" {
  vpc_id = "vpc"
  name   = "mongo_sg"

resource "aws_security_group_rule" "mongo_ingress_27017" {
  security_group_id = "${aws_security_group.mongo_sg.id}"
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_private_subnet_7}","${var.vpc_public_subnet_8}","${var.vpc_private_subnet_9}"]
}

resource "aws_security_group_rule" "mongo_ingress_1" {
  security_group_id = "${aws_security_group.mongo_sg.id}"
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["${var.vpc_private_subnet_7}","${var.vpc_private_subnet_8}","${var.vpc_private_subnet_9}"]
}

resource "aws_security_group_rule" "mongo_egress_all" {
  security_group_id = "${aws_security_group.mongo_sg.id}"
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = ["${var.vpc_private_subnet_7}","${var.vpc_public_subnet_8}","${var.vpc_private_subnet_9}"]
}

  resource "aws_security_group_rule" "mongo_egress_1" {
  security_group_id = "${aws_security_group.mongo_sg.id}"
  type = "egress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["${var.vpc_private_subnet_7}","${var.vpc_public_subnet_8}","${var.vpc_private_subnet_9}"]
}
