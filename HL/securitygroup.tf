

alb_external_sg

alb_internal_sg



resource "aws_security_group" "vpn_sg" {

    vpc_id = "vpc"
    name   = "vpn_sg"
  
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 943
        to_port = 943
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 1194
        to_port = 1194
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "vpn_sg"
    }
}
