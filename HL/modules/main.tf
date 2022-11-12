


resource "aws_instance" "mongo" {
  count                  = "3"
  ami                    = "ami-0e34af9d3686f9ace"
  instance_type          = "t2.large"
  key_name               = " "
  subnet_id              = " "
  vpc_security_group_ids = ["${aws_security_group.mongo_sg.id}"]
#  iam_instance_profile   = " "
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }

  tags = {
    Name = "mongo_${count.index + 1}"
  }
  
 
##### for static ips #######  

resource "aws_network_interface" "test" {
  subnet_id       = aws_subnet.xxxxxxx.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.web.id]

  attachment {
    instance     = aws_instance.mongo.id
    device_index = 1
  }
}
