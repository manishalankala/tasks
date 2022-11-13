#### vpn with public ip association ####

resource "aws_eip" "vpn_eip" {
  instance = aws_instance.vpn.id
  vpc = true
} 


#### alb with public ip association (optional) ####

resource "aws_eip" "alb_eip1" {
  instance = aws_lb.alb.id
  vpc = true
} 


#### alb with public ip association (optional) ####

resource "aws_eip" "alb_eip2" {
  instance = aws_lb.alb.id
  vpc = true
} 


resource "aws_eip" "nat_eip"  {
	vpc  = true
	tags = {
		Name = "nateip"
	}
}
