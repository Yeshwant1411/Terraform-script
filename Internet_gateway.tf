resource "aws_internet_gateway" "igw_vpc" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "YT-Internet Gateway"
  }
}

//4. Route table for public subnet
resource "aws_route_table" "yt_route_table_public_subnet" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc.id
  }
  tags = {
    Name = "Public subnet Route Table"
  }
}
