resource "aws_security_group" "ec2_sg" {
  name        = "yt-ec2-sg"
  description = "Security Group for Web Server Instances"

  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "yt-ec2-sg"
  }
}
