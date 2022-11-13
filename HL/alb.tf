

resource "aws_lb" "alb" {
  name               = "alb"
  load_balancer_type = "application"
  
  subnet_mapping {
    subnet_id     = aws_subnet.vpc_public_subnet_3.id
    allocation_id = aws_eip.alb_eip1.id
#    private_ipv4_address = "xxxxxxx"
  }

  subnet_mapping {
    subnet_id     = aws_subnet.vpc_public_subnet_4.id
    allocation_id = aws_eip.alb_eip1.id
#    private_ipv4_address = "xxxxxxxxx"
  }
}


#### Note eip for this alb is optional or it can for internal with private ip #####
