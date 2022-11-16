

### 1. External load balancer
### 1. Internal load balancer
### target group for the external load balancer
### listener for the load balancer


#-------------------------------------
# External load balancer
#-------------------------------------

resource "aws_lb" "alb_external" {
  name                 = "alb_external"
  load_balancer_type   = "application"
  internal             = false
  ip_address_type      = "ipv4"
  subnets = [vpc_public_subnet_3.id,vpc_public_subnet_4.id]
  security_groups = [ aws_security_group.alb_external_sg.id]                          ]
}

#-------------------------------------
# External load balancer - Target Group 1
#-------------------------------------

resource "aws_lb_target_group" "nginx1-tg" {
  name     = "nginx2_tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  deregistration_delay = 60
  stickiness {
    enabled = false
    type    = "lb_cookie"
    cookie_duration = 60
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    matcher             = 200

  }

  lifecycle {
    create_before_destroy = true
  }
}

#-------------------------------------
# External load balancer - Target Group 2
#-------------------------------------

resource "aws_lb_target_group" "nginx2_tg" {
  name     = "nginx2_tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.main.id
  deregistration_delay = 60
  stickiness {
    enabled = false
    type    = "lb_cookie"
    cookie_duration = 60
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    path                = "/"
    protocol            = "HTTPS"
    matcher             = 200

  }

  lifecycle {
    create_before_destroy = true
  }
}




#========================================================
#  External load balancer - http listener 
#========================================================

resource "aws_lb_listener" "listner" {
  
  load_balancer_arn = aws_lb.lb.id
  port              = 80
  protocol          = "HTTP"
  
#-------------------------------------
#defualt action of the target group.
#-------------------------------------

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = " No such Site Found"
      status_code  = "200"
   }
}
    
  depends_on = [  aws_lb.alb_external ]
}



resource "aws_lb_listener" "nginx_ls" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
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
