resource "aws_vpc" "terraform_vpc" {
  cidr_block       = var.tf_vpc_cider_block
  instance_tenancy = "default"
  tags = {
    Name    = var.tf_vpc_name
    projeto = "labs-terraform"
  }
}

resource "aws_subnet" "sub-priv-terraform" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = var.tf_subnet_priv_cider_block
  depends_on = [aws_vpc.terraform_vpc]
  tags = {
    Name    = var.tf_sub_priv_name
    projeto = "labs-terraform"
  }
}

resource "aws_subnet" "sub-pub-terraform" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = var.tf_subnet_pub_cider_block
  depends_on = [aws_vpc.terraform_vpc]
  tags = {
    Name    = var.tf_sub_pub_name
    projeto = "labs-terraform"
  }
}

resource "aws_internet_gateway" "int-gate-terraform" {
  tags = {
    Name    = var.tf_ig_name
    projeto = "labs-terraform"
  }
}

resource "aws_internet_gateway_attachment" "gw-atach" {
  internet_gateway_id = aws_internet_gateway.int-gate-terraform.id
  vpc_id              = aws_vpc.terraform_vpc.id
}

resource "aws_eip" "lb-terraform" {
  depends_on = [aws_internet_gateway.int-gate-terraform]
  tags = {
    Name    = var.tf_ip_name
    projeto = "labs-terraform"
  }
}

resource "aws_nat_gateway" "nat-gate-terraform" {
  allocation_id = aws_eip.lb-terraform.id
  subnet_id     = aws_subnet.sub-pub-terraform.id

  tags = {
    Name    = var.tf_nat_gw_name
    projeto = "labs-terraform"
  }

  depends_on = [aws_internet_gateway.int-gate-terraform]
}

resource "aws_route_table" "public-terraform-rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int-gate-terraform.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  depends_on = [aws_internet_gateway.int-gate-terraform]

  tags = {
    Name    = var.tf_rt_publica_name
    projeto = "labs-terraform"
  }
}

resource "aws_route_table" "priv-terraform-rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gate-terraform.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  depends_on = [aws_nat_gateway.nat-gate-terraform]

  tags = {
    Name    = var.tf_rt_privada_name
    projeto = "labs-terraform"
  }
}

resource "aws_route_table_association" "ass-rt-pub" {
  subnet_id      = aws_subnet.sub-pub-terraform.id
  route_table_id = aws_route_table.public-terraform-rt.id
  depends_on     = [aws_route_table.public-terraform-rt]
}

resource "aws_route_table_association" "ass-rt-priv" {
  subnet_id      = aws_subnet.sub-priv-terraform.id
  route_table_id = aws_route_table.priv-terraform-rt.id
  depends_on     = [aws_route_table.priv-terraform-rt]
}

