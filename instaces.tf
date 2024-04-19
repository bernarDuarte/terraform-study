locals {
  ec2_ami = var.ec2_ami
}

resource "aws_instance" "ec2-pub" {
  ami                         = local.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.sub-pub-terraform.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.pub-sg-terraform.id]
  key_name                    = aws_key_pair.terraform-labs.id
  user_data                   = file("./instalacao-docker.sh")
  tags = {
    Name    = var.ec2_instance_name_pub
    projeto = "labs-terraform"
  }
}

resource "aws_instance" "ec2-priv" {
  ami                    = local.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.sub-priv-terraform.id
  vpc_security_group_ids = [aws_security_group.priv-sg-terraform.id]
  key_name               = aws_key_pair.terraform-labs.id
  user_data              = file("./instalacao-docker.sh")
  tags = {
    Name    = var.ec2_instance_name_priv
    projeto = "labs-terraform"
  }
}


resource "aws_key_pair" "terraform-labs" {
  key_name   = var.ec2_instance_key_pair_name
  public_key = file("~/.ssh/aula-terraform.pub")
}

