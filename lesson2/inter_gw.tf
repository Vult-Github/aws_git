resource "aws_internet_gateway" "lesson2gw" {
  tags = {
    Name = "lesson2gw"
    Type = "inter_gw"
  }
}

resource "aws_internet_gateway_attachment" "lesson2gwattach" {
  internet_gateway_id = aws_internet_gateway.lesson2gw.id
  vpc_id              = aws_vpc.lesson2_vpc.id
}
