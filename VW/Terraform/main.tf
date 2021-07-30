provider "aws" {
  version = "~> 2.57.0"
  region  = "us-east-1"
}



################################
########### VPC-A ################
################################


resource "aws_vpc" "vpc-a" {
  name                 = "VPC-A"
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}


resource "aws_internet_gateway" "vpca" {
  name        = "vpcagwInternet"
  vpc_id = aws_vpc.vpc-a.id
}


resource "aws_subnet" "pubsub1" {
  name              = "public-subnet-1"
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc-a.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-east-1a"
  depends_on        = [ aws_vpc.vpc-a,]

}


resource "aws_subnet" "privsub1" {
  name              = "private-subnet-1"
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc-a.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"
  depends_on        = [ aws_vpc.vpc-a,]

}


################################
###### Public Route #######
################################

resource "aws_route_table" "publicrt" {
  name      = "PUBLIC1-RT"
  vpc_id    = aws_vpc.vpc-a.id
}

resource "aws_route" "public" {
  route_table_id          = aws_route_table.publicrt.id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.vpca.id
}


# associate route table to public subnet

resource "aws_route_table_association" "associate_routetable_to_public_subnet" {
  depends_on       = [ aws_subnet.pubsub1,aws_route_table.publicrt,]
  subnet_id        = aws_subnet.pubsub1.id
  route_table_id   = aws_route_table.publicrt.id
}


################################
###### Private Route #######
################################


resource "aws_route_table" "privrt" {
  name      = "PRIVATE1-RT"
  vpc_id    = aws_vpc.vpc-a.id
}


# associate route table to private subnet

resource "aws_route_table_association" "associate_routetable_to_public_subnet" {
  depends_on       = [ aws_subnet.privsub1,aws_route_table.privrt,]
  subnet_id        = aws_subnet.privsub1.id
  route_table_id   = aws_route_table.privrt.id
}


################################
#### Secuirty group TCP ####
################################


resource "aws_security_group" "allow_tcp1" {
  name        = "ALLOW_tcp"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-a.id
  ingress {
    description = "allow TCP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

################################
#### Secuirty group SSH ####
################################
  
resource "aws_security_group" "allow_ssh1" {
  name        = "ALLOW_ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-a.id
  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  
  
  
  
  
  
  
  
  
################################
########### VPC-B ################
################################

resource "aws_vpc" "vpc-a" {  
  name                 = "VPC-B"
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}


resource "aws_internet_gateway" "vpcb" {
  name        = "vpcbgwInternet"
  vpc_id = aws_default_vpc.vpc-b.id
}


resource "aws_subnet" "pubsub2" {
  name              = "public-subnet-2"
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc-b.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-east-1c"
  depends_on        = [ aws_vpc.vpc-b,]

}


resource "aws_subnet" "privsub2" {
  name              = "private-subnet-2"
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc-b.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1c"
  depends_on        = [ aws_vpc.vpc-b,]

}

################################
###### Public Route #######
################################

resource "aws_route_table" "publicrt" {
  name   = "PUBLIC2-RT"
  vpc_id = aws_vpc.vpc-a.id
}

resource "aws_route" "public" {
  route_table_id          = aws_route_table.publicrt.id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.vpcb.id
}

# associate route table to public subnet
resource "aws_route_table_association" "associate_routetable_to_public_subnet" {
  depends_on       = [ aws_subnet.pubsub1,aws_route_table.publicrt,]
  subnet_id        = aws_subnet.pubsub2.id
  route_table_id   = aws_route_table.publicrt.id
}

  
  
################################
###### Private Route #######
################################
  
  
resource "aws_route_table" "privrt" {
  name      = "PRIVATE1-RT"
  vpc_id    = aws_vpc.vpc-a.id
}


# associate route table to private subnet

resource "aws_route_table_association" "associate_routetable_to_public_subnet" {
  depends_on       = [ aws_subnet.privsub1,aws_route_table.privrt,]
  subnet_id        = aws_subnet.privsub1.id
  route_table_id   = aws_route_table.privrt.id
}

  
################################  
###### Security Group TCP #######
################################
  
resource "aws_security_group" "allow_tcp2" {
  name        = "ALLOW_tcp"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-b.id
  ingress {
    description = "allow TCP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

################################
###### Security Groups SSH #######  
################################
  
resource "aws_security_group" "allow_ssh2" {
  name        = "ALLOW_ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-b.id
  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.2.0.0/16"]
  }
  
  
  
###########################
# Transit Gateway Section #
###########################
  
  
resource "aws_ec2_transit_gateway" "mytgw" {
  name                              = "mytgw"
  description                       = "Transit Gateway testing scenario with 4 VPCs, 2 subnets each"
  default_route_table_association   = "disable"
  default_route_table_propagation   = "disable"
}


  
# VPC-A attachment to TGW
  
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-a" {
  name                = "tgw-att-vpca"
  subnet_ids          = ["${aws_subnet.pubsub1.id}", "${aws_subnet.privsub1.id}"]
  transit_gateway_id  = "aws_ec2_transit_gateway.mytgw.id"
  vpc_id              = aws_vpc.vpc-a.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  depends_on = ["aws_ec2_transit_gateway.mytgw"]
}
  
# VPC-B attachment to TGW
  
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-a" {
  name                = "tgw-att-vpca"
  subnet_ids          = ["${aws_subnet.pubsub2.id}", "${aws_subnet.privsub2.id}"]
  transit_gateway_id  = "aws_ec2_transit_gateway.mytgw.id"
  vpc_id              = aws_vpc.vpc-b.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  depends_on = ["aws_ec2_transit_gateway.mytgw"]
} 


# Route Tables
  
resource "aws_ec2_transit_gateway_route_table" "tgw-vpca-rt" {
  name                = "tgw-vpc-a-rt"
  transit_gateway_id  = "${aws_ec2_transit_gateway.mytgw.id}"
  depends_on          = ["aws_ec2_transit_gateway.mytgw"]
}

resource "aws_ec2_transit_gateway_route_table" "tgw-vpcb-rt" {
  name               = "tgw-vpc-b-rt"
  transit_gateway_id = aws_ec2_transit_gateway.mytgw.id
  depends_on = ["aws_ec2_transit_gateway.mytgw"]
}
  
  
#### Route Tables Associationsfor TGW
## This is the link between a VPC (already symbolized with its attachment to the Transit Gateway) and the Route Table the VPC's packet will hit when they arrive into the Transit Gateway.  

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-a-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-a.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-vpca-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-b-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-b.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-vpcb-rt.id}"
}

  
# Route Tables Propagations
## This section defines which VPCs will be routed from each Route Table created in the Transit Gateway

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-dev-to-vpc-a" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-a.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-vpca-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-dev-to-vpc-b" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-b.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-vpcb.id}"
}

  
############################# 
### EKS Cluster Resources
############################# 
  
  
resource "aws_eks_cluster" "eks" {
  name = "eks-cluster"
  version = "1.19"
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    security_group_ids = aws_security_group.cluster.id
    subnet_ids         = aws_subnet_ids.privsub1.id
  }

  enabled_cluster_log_types = var.eks-cw-logging

  depends_on = [aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy,]
}
  
  
  
  resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = "eks-cluster"
  node_group_name = "eks-cluster-default-node-group"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = data.aws_subnet_ids.private.ids
  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }
  instance_types = t3.micro
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_eks_cluster.eks,
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy
  ]
  tags = {
    Name = "eks-cluster-default-node-group"
  }
}
