resource "aws_launch_template" "template" {
  name          = "template"
  image_id      = "xxxxxxx"
  instance_type = "t2.micro"
  user_data = filebase64("${path.module}/startup.sh")
  network_interfaces {
#    associate_public_ip_address = true
    security_groups             = aws_security_group.nginx_sg.id
  }
}


resource "aws_autoscaling_group" "nginx_asg" {
  name                      = "nginx_asg"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  #availability_zones = var.availability_zones #["us-east-1a"]
  vpc_zone_identifier = aws_subnet.vpc_public_subnet_2.id

  launch_template {
    id      = aws_launch_template.template.id
  }

}
