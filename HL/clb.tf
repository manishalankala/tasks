


resource "aws_lb" "classic" {
  name    = "classic"
  subnets = [aws_subnet.vpc_public_subnet_5.id, aws_subnet.vpc_public_subnet_6.id]

listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port= 80
    lb_protocol= "http"
  }

security_groups = [aws_security_group. .id]

  tags = {
    Name = "classic"
  }
}

output "dns_name" {    
  value = aws_lb.classic.dns_name
}
