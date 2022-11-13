#### vpn_sg is added to nginx

resource "aws_security_group" "nginx_sg" {
    name = "nginx_sg"
    vpc_id  = aws_vpc.vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_group_id = "${aws_security_group.vpn_sg.id}"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_group_id = "${aws_security_group.vpn_sg.id}"
    }
    tags {
        Name = "nginx_sg"
    }
}
