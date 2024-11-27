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

resource "aws_route_table_association" "private_subnet_association" {
  route_table_id = aws_route_table.yt_route_table_private_subnet.id
  count          = length(var.vpc_availability_zones)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
}
