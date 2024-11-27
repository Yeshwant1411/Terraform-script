resource "aws_security_group" "alb_sg" {
  name        = "yt-alb-sg"
  description = "Security Group for Application Load Balancer"

  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "yt-alb-sg"
  }
}
