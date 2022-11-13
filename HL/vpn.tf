
#### Note ####
#### VPN Server with image alternatively we can create via ansible roles also and create an ami and utilize that using data #####


resource "aws_instance" "vpn" {
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




output "access_vpn_url" {
  value       = "https://${aws_eip.vpn_eip}:943/admin"
  description = "The public url address of the vpn server"
}
