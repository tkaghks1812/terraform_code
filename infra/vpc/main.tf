resource "aws_vpc" "user05-vpc" {
  cidr_block = var.cidr_block


  tags = {
    Name = "user05-vpc"
  }
}

resource "aws_subnet" "user05-public01" {
  vpc_id            = aws_vpc.user05-vpc.id
  cidr_block        = var.public_subnet_cidr[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "user05-public01"
  }
}
resource "aws_subnet" "user05-public02" {
  vpc_id            = aws_vpc.user05-vpc.id
  cidr_block        = var.public_subnet_cidr[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "user05-public02"
  }
}
resource "aws_subnet" "user05-private01" {
  vpc_id            = aws_vpc.user05-vpc.id
  cidr_block        = var.private_subnet_cidr[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "user05-private01"
  }
}
resource "aws_subnet" "user05-private02" {
  vpc_id            = aws_vpc.user05-vpc.id
  cidr_block        = var.private_subnet_cidr[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "user05-private02"
  }
}
resource "aws_internet_gateway" "user05-igw" {
  vpc_id = aws_vpc.user05-vpc.id

  tags = {
    Name = "user05-igw"
  }
}
//EIP 생성
resource "aws_eip" "user05-eip" {
  domain = "vpc"
  //depends_on = [ "aws_internet_gateway.user05-igw" ]
  lifecycle{
    create_before_destroy = true
  }
  tags = {
    Name = "user05-eip"
  }
}
resource "aws_nat_gateway" "user05-nat-gw" {
  allocation_id = aws_eip.user05-eip.id
  subnet_id     = aws_subnet.user05-public01.id
  //depends_on = [ "aws_internet_gateway.user05-igw" ]
  tags = {
    Name = "user05-nat-gw"
  }  
}

resource "aws_default_route_table" "user05-public-rt" {
  default_route_table_id = aws_vpc.user05-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.user05-igw.id
  }
  tags = {
    Name = "user05-public-rt"
  }
}
//public subnet과 route table연결
resource "aws_route_table_association" "user05-public01-rt-assoc" {
  subnet_id = aws_subnet.user05-public01.id
  route_table_id = aws_default_route_table.user05-public-rt.id
}

resource "aws_route_table_association" "user05-public02-rt-assoc" {
  subnet_id = aws_subnet.user05-public02.id
  route_table_id = aws_default_route_table.user05-public-rt.id
}

//private Route Table 생성
resource "aws_route_table" "user05-private-rt" {
  vpc_id = aws_vpc.user05-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.user05-nat-gw.id
    }
  tags = {
    Name = "user05-private-rt"
  }
  
}


//private subnet과 priavte route table연결
resource "aws_route_table_association" "user05-private01-rt-assoc" {
  subnet_id = aws_subnet.user05-private01.id
  route_table_id = aws_route_table.user05-private-rt.id
}

resource "aws_route_table_association" "user05-private02-rt-assoc" {
  subnet_id = aws_subnet.user05-private02.id
  route_table_id = aws_route_table.user05-private-rt.id
}
//vpc End