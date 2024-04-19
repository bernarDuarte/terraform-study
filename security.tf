resource "aws_security_group" "pub-sg-terraform" {
  name   = var.tf_sg_pub_name
  vpc_id = aws_vpc.terraform_vpc.id

  dynamic "ingress" {
    for_each = var.tf_sg_pub_ing
    content {
      description      = ingress.value["description"]
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
      ipv6_cidr_blocks = ingress.value["ipv6_cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.tf_sg_pub_eg
    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = egress.value["cidr_blocks"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]
    }
  }
  tags = {
    Name    = var.tf_sg_pub_name
    projeto = "labs-terraform"
  }

}


resource "aws_security_group" "priv-sg-terraform" {
  name   = var.tf_sg_priv_name
  vpc_id = aws_vpc.terraform_vpc.id

  ingress {
    description     = "Acesso mongo"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.pub-sg-terraform.id]
  }

  ingress {
    description = "Acesso SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  dynamic "egress" {
    for_each = var.tf_sg_priv_eg
    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = egress.value["cidr_blocks"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]
    }
  }

  tags = {
    Name    = var.tf_sg_priv_name
    projeto = "labs-terraform"
  }

}


resource "aws_network_acl" "nal-pub-terraformmain" {
  vpc_id = aws_vpc.terraform_vpc.id
  
  dynamic "ingress" {
    for_each = var.tf_net_acl_pub_ing
    content {
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_block      = ingress.value["cidr_block"]
      action = ingress.value["action"]
      rule_no = ingress.value["rule_no"]
    }
  }

  dynamic "egress" {
    for_each = var.tf_net_acl_pub_eg
    content {
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_block      = egress.value["cidr_block"]
      action = egress.value["action"]
      rule_no = egress.value["rule_no"]
    }
  }

  tags = {
    Name    = "nal-pub-terraform"
    projeto = "labs-terraform"
  }

}

resource "aws_network_acl" "nal-priv-terraformmain" {
  vpc_id = aws_vpc.terraform_vpc.id

  dynamic "ingress" {
    for_each = var.tf_net_acl_priv_ing
    content {
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_block      = ingress.value["cidr_block"]
      action = ingress.value["action"]
      rule_no = ingress.value["rule_no"]
    }
  }

  dynamic "egress" {
    for_each = var.tf_net_acl_priv_eg
    content {
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_block      = egress.value["cidr_block"]
      action = egress.value["action"]
      rule_no = egress.value["rule_no"]
    }
  }


  tags = {
    Name    = "nal-priv-terraform"
    projeto = "labs-terraform"
  }
}


resource "aws_network_acl_association" "assos-pub-acl" {
  network_acl_id = aws_network_acl.nal-pub-terraformmain.id
  subnet_id      = aws_subnet.sub-pub-terraform.id
}

resource "aws_network_acl_association" "assos-priv-acl" {
  network_acl_id = aws_network_acl.nal-priv-terraformmain.id
  subnet_id      = aws_subnet.sub-priv-terraform.id
}
