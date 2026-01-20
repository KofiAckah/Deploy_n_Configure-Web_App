# Security Group for EC2 Instance
resource "aws_security_group" "web" {
  name        = "${var.project_name}-web-sg"
  description = "Security group for web server"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-web-sg"
  }
}

# SSH Ingress Rule
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

  tags = {
    Name = "${var.project_name}-ssh-ingress"
  }
}

# HTTP Ingress Rule
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"

  tags = {
    Name = "${var.project_name}-http-ingress"
  }
}

# HTTPS Ingress Rule
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"

  tags = {
    Name = "${var.project_name}-https-ingress"
  }
}

# Egress Rule - Allow all outbound traffic IPv4
resource "aws_vpc_security_group_egress_rule" "all_traffic_ipv4" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"  # All protocols

  tags = {
    Name = "${var.project_name}-all-egress-ipv4"
  }
}