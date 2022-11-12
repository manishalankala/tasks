resource "aws_lb" "internal_lb" {
  name               = "internal_lb"
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id            = aws_subnet.xx.id
    private_ipv4_address = "xxxxxxx"
  }

  subnet_mapping {
    subnet_id            = aws_subnet.xxx.id
    private_ipv4_address = "xxxxxxx"
  }
  
  subnet_mapping {
    subnet_id            = aws_subnet.xxxx.id
    private_ipv4_address = "xxxxxxx"
  }
  
}
