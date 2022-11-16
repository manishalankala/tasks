

### 1. External load balancer
### 1. Internal load balancer




resource "aws_lb" "alb_external" {
  name                 = "alb_external"
  load_balancer_type   = "application"
  internal             = false
  ip_address_type      = "ipv4"
  subnets = [vpc_public_subnet_3.id,vpc_public_subnet_4.id]
  security_groups = [ aws_security_group.alb_external_sg.id]                          ]
}




resource "aws_lb" "alb_internal" {
  name                       = "alb_internal"
  internal                   = true
  enable_deletion_protection = true 
  ip_address_type            = "ipv4"
  subnets = [vpc_private_subnet_3.id,vpc_private_subnet_4.id]
  security_groups = [ aws_security_group.alb_internal_sg.id]  
}






######### Aleternative #########

#resource "aws_lb" "alb_external" {
#  name                 = "alb_external"
#  load_balancer_type   = "application"
#  internal             = false
#  ip_address_type      = "ipv4"
#  subnet_mapping {
#    subnet_id     = aws_subnet.vpc_public_subnet_3.id
#    allocation_id = aws_eip.alb_eip1.id
#    private_ipv4_address = "xxxxxxx"
#  } 
#  subnet_mapping {
#    subnet_id     = aws_subnet.vpc_public_subnet_4.id
#    allocation_id = aws_eip.alb_eip1.id
#    private_ipv4_address = "xxxxxxxxx"
#  }
#}
