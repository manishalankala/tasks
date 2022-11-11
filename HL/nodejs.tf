
###### Creating Launch Configuration ######


resource "aws_launch_configuration" "nodejs" {
  name_prefix     = "nodejs-"
  image_id        = "xxxxxxxxx "
  instance_type   = "t2.medium"
  user_data       = file("startup.sh")
  security_groups = [aws_security_group.nginx_sg.id]
  
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)

    }
  }
  
  
  provisioner "local-exec" {
    command = "ansible-playbook --private-key ${var.private_key_path} /path/nodejs.yaml"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "nginx" {
  name                 = "nginx"
  min_size             = 2
  max_size             = 2
#  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.nginx.name
  tag {
    key                 = "Name"
    value               = "Nginx with Terraform and Ansible"
    propagate_at_launch = true
  }
}
