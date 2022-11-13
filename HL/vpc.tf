### Key ####

resource "aws_key_pair" "ec2loginkey" {
  key_name = "login-key"
  ## change here if you are using different key pair
  public_key = file(pathexpand(var.ssh_key_pair_pub))
}


###### VPC ######

resource "aws_vpc" "vpc" {
  name = "vpc"
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags {
    Name = "vpc"
  }
}


###### Internet gateway ######

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.vpc}_igw"
  }
}




###### Private subnet ######

resource "aws_subnet" "vpc_private_sn_1" {
  vpc_id            = "${aws_vpc.vpc_name.id}"
  cidr_block        = "${var.vpc_private_subnet_1_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "false"

  tags {
    Name = "${var.vpc_name}_vpc_private_sn_1"
  }
}




###### nat gateway ###### 

resource "aws_eip" "nat" {
  vpc = true

  tags {
    Name = "${var.vpc_name}_nat_eip"
  }
}

resource "aws_nat_gateway" "vpc_nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.vpc_public_sn_1.id}"
  depends_on    = ["aws_internet_gateway.vpc_ig"]

  tags {
    Name = "${var.vpc_name}_nat"
  }
}

######  Routing table for public subnet ###### 

resource "aws_route_table" "vpc_public_sn_rt" {
  vpc_id = "${aws_vpc.vpc_name.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_ig.id}"
  }

  tags {
    Name = "vpc_public_sn_rt"
  }
}

######  Routing table for private subnet ###### 

resource "aws_route_table" "vpc_private_sn_rt" {
  vpc_id = "${aws_vpc.vpc_name.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.vpc_nat.id}"
  }

  tags {
    Name = "vpc_private_sn_rt"
  }
}



#######  Associate the routing table to public subnet ###### 

resource "aws_route_table_association" "vpc_public_sn_rt_assn" {
  subnet_id      = "${aws_subnet.vpc_public_sn_1.id}"
  route_table_id = "${aws_route_table.vpc_public_sn_rt.id}"
}


#######  Associate the routing table to private subnet ###### 

resource "aws_route_table_association" "vpc_private_sn_rt_assn" {
  subnet_id      = "${aws_subnet.vpc_private_sn_1.id}"
  route_table_id = "${aws_route_table.vpc_private_sn_rt.id}"
}



####### security group Nginx #######

resource "aws_security_group" "nginx_sg" {

    vpc_id = "${aws_vpc.vpc_name.id}"
    name   = "nginx_sg"
  
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "nginx_sg"
    }
}


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