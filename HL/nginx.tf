###### Creating Launch Configuration ######


resource "aws_launch_configuration" "nginx" {
  name_prefix     = "nginx-"
  image_id        = "xxxxxxxxx"
  instance_type   = "t2.medium"
  user_data       = file("startup.sh")
  security_group = "aws_security_group.nginx_sg.id"
  
  provisioner "file" {
    source      = "/start.sh"
    destination = "/tmp/start.sh"
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/manish/keys/aws_key")
    host        = aws_instance.nginx.public_ip
    }
  }
  
  provisioner "remote-exec" {
    inline = [ echo whoami ]
  }
  
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.nginx.public_ip} --private-key ${var.private_key_path} /path/nginx.yaml"
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


output "nginx_ip" {
  value = aws_instance.nginx.public_ip
}
