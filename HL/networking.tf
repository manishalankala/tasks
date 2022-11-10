

### VPC

resource "aws_vpc" "vpc_name" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "${var.vpc_name}"
  }
}
