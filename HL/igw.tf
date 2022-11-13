
###### Internet gateway ######

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.vpc}_igw"
  }
}
