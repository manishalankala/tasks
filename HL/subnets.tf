###### Public subnet vpn ######

rresource "aws_subnet" "vpc_public_subnet_1" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_subnet_1"
  }
}

###### Public subnet ngix ######

resource "aws_subnet" "vpc_public_subnet_2" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_subnet_2"
  }
}

###### Public subnet alb ######

resource "aws_subnet" "vpc_public_subnet_3" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_subnet_3"
  }
}


###### Public subnet alb ######

resource "aws_subnet" "vpc_public_subnet_4" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_subnet_4"
  }
}

###### Public subnet additional ######

resource "aws_subnet" "vpc_public_subnet_4" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.5.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_subnet_4"
  }
}

###### Public subnet additional ######

resource "aws_subnet" "vpc_public_subnet_4" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.6.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_subnet_4"
  }
}



###### Private subnet ######

resource "aws_subnet" "vpc_private_subnet_1" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.7.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "false"

  tags {
    Name = "${var.vpc_name}_vpc_private_sn_1"
  }
}

###### Private subnet ######

resource "aws_subnet" "vpc_private_subnet_2" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.8.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "false"

  tags {
    Name = "${var.vpc_name}_vpc_private_subnet_2"
  }
}


###### Private subnet ######

resource "aws_subnet" "vpc_private_subnet_3" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.9.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "false"

  tags {
    Name = "${var.vpc_name}_vpc_private_subnet_3"
  }
}

###### Private subnet ######

resource "aws_subnet" "vpc_private_subnet_4" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.10.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "false"

  tags {
    Name = "${var.vpc_name}_vpc_private_subnet_4"
  }
}
