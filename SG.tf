resource "aws_security_group" "LB-SG" {
  name        = "LB-SG"
  description = "allow all inbound http traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "${var.default_tags.env}-LB-SG"
  }
}

resource "aws_security_group" "EC2-SG" {
  name        = "EC2-SG"
  description = "allow all inbound http traffic from LB-SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP from LB-SG"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    security_groups  = [aws_security_group.LB-SG.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "${var.default_tags.env}-EC2-SG"
  }
}
