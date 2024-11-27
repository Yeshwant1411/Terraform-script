resource "aws_route_table" "yt_route_table_private_subnet" {
  depends_on = [aws_nat_gateway.yt-nat-gateway]
  vpc_id     = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.yt-nat-gateway.id
  }
  tags = {
    Name = "Private subnet Route Table"
  }
}
