


resource "aws_instance" "vpn_server" {
  ami     = "ami-0764964fdfe99bc31"
  instance_type          = "t2.medium" 
  user_data = <<-EOF
              admin_user=${var.server_username}
              admin_pw=${var.server_password}
              EOF
  
  tags = {
    Name = "vpn"
  }
}
