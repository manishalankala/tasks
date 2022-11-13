


resource "aws_security_group" "application_sg" {
    name = "app_sg"
    vpc_id  = aws_vpc.vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
#        security_group_id = "${aws_security_group.vpn_sg.id}"
    }
    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
#        security_group_id = "${aws_security_group.vpn_sg.id}"
    }
    tags {
        Name = "nginx_sg"
    }
}
