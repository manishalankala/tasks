###### Public subnet ######

rresource "aws_subnet" "vpc_public_subnet_1" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_subnet_1"
  }
}


rresource "aws_subnet" "vpc_public_subnet_2" {
  vpc_id            = "vpc"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_subnet_1"
  }
}
