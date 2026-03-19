provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo-server" {
  ami = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.micro"
  key_name = "dpp"
  security_groups = [ "demo-sg" ]
}

resource "aws_security_group" "demo-sg" {
  name   = "demo-sg"
  description = "SSH Access"
  tags = {
    Name = "ssh-prot"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.demo-sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = ["0.0.0.0/0"]
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.demo-sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = ["0.0.0.0/0"]
}