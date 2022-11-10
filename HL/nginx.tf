###### Creating Launch Configuration ######


resource "aws_launch_configuration" "nginx" {
  name_prefix     = "nginx-"
  image_id        = " "
  instance_type   = "t2.medium"
  user_data       = file("startup.sh")
  security_groups = [aws_security_group.nginx_sg.id]
  
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = aws_instance.nginx.public_ip
    }
  }
  
  
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.nginx.public_ip}, --private-key ${var.private_key_path} nginx.yaml"
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
