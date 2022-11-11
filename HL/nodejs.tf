
###### Creating Launch Configuration ######


resource "aws_launch_configuration" "nodejs" {
  name_prefix     = "nodejs-"
  image_id        = "xxxxxxxxx "
  instance_type   = "t2.medium"
  security_groups = [aws_security_group.nginx_sg.id]
  
 provisioner "file" {
    source      = "HL/start.sh"
    destination = "/tmp/start.sh"
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/manish/keys/aws_key")
    host        = aws_instance.nginx.public_ip
    }
  }

  
 provisioner "remote-exec" {
    inline = [
      "sudo ln -s /usr/bin/python3 /usr/bin/python",
      "chmod +x /tmp/start.sh",
      "./tmp/wait-for-cloud-init.sh",
    ]
  }
  
 provisioner "local-exec" {
    command = "ansible-playbook --private-key ${var.private_key_path} /HL/nodejs.yaml"
  }

#    # Execute Ansible Playbook
# provisioner "remote-exec" {
#    inline = [
#      "sleep 120; ansible-playbook nginx.yaml"
#    ]
#    connection {
#      type        = "ssh"
#      user        = "ec2-user"
#      private_key = file(pathexpand(var.ssh_key_pair))
#      host        = self.public_ip
#    }
#  }
  
  
  
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "nodejs" {
  name                 = "nodejs"
  min_size             = 2
  max_size             = 3
  launch_configuration = aws_launch_configuration.nodejs.name
  tag {
    key                 = "Name"
    value               = "Nodejs with Terraform and Ansible"
    propagate_at_launch = true
  }
}
