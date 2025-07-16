resource "aws_security_group" "resume-sg" {

 name = "allow tls"
 vpc_id = var.vpc_id
 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  } 
 tags = {
  
  Name = "resume-sg"
 
}

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.resume-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.resume-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_8080" {
  security_group_id = aws_security_group.resume-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow_docker_7946_tcp" {
  security_group_id = aws_security_group.resume-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 7946
  ip_protocol       = "tcp"
  to_port           = 7946
}

resource "aws_vpc_security_group_ingress_rule" "allow_docker_7946_udp" {
  security_group_id = aws_security_group.resume-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 7946
  ip_protocol       = "udp"
  to_port           = 7946
}

resource "aws_vpc_security_group_ingress_rule" "allow_docker_4789_udp" {
  security_group_id = aws_security_group.resume-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 4789
  ip_protocol       = "udp"
  to_port           = 4789
}

resource "aws_vpc_security_group_ingress_rule" "allow_docker_2377" {
  security_group_id = aws_security_group.resume-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 2377
  ip_protocol       = "tcp"
  to_port           = 2377
}