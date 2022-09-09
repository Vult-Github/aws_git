resource "aws_route_table" "lesson2_vpcsubAroutetable" {
  vpc_id = aws_vpc.lesson2_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lesson2gw.id
  }
  tags = {
    Name = "lesson2 route for subA"
    Type = "Route table subnet"
  }
  depends_on = [aws_internet_gateway_attachment.lesson2gwattach]
}
resource "aws_route_table_association" "lesson2routetablesubAAssoc" {
  subnet_id      = aws_subnet.lesson2_subA.id
  route_table_id = aws_route_table.lesson2_vpcsubAroutetable.id
}
