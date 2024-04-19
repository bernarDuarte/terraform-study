# 
# 
#---------Vpc---------
# 
# 
#
variable "project_region" {
  type        = string
  default     = "us-east-1"
  description = "Region for the project"
}

variable "tf_vpc_name" {
  type        = string
  default     = "main-terraform"
  description = "Region for the project"
}

variable "tf_vpc_cider_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Region for the project"
}


variable "tf_sub_pub_name" {
  type        = string
  default     = "sub-pub-terraform"
  description = "Region for the project"
}

variable "tf_subnet_pub_cider_block" {
  type        = string
  default     = "10.0.0.0/24"
  description = "Region for the project"
}

variable "tf_sub_priv_name" {
  type        = string
  default     = "sub-priv-terraform"
  description = "Region for the project"
}

variable "tf_subnet_priv_cider_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "Region for the project"
}

variable "tf_ig_name" {
  type        = string
  default     = "terraform_igw"
  description = "Region for the project"
}

variable "tf_ip_name" {
  type        = string
  default     = "ip-terraform"
  description = "Region for the project"
}

variable "tf_nat_gw_name" {
  type        = string
  default     = "nat-gate-terraform"
  description = "Region for the project"
}

variable "tf_rt_publica_name" {
  type        = string
  default     = "pub-route-table-terraform"
  description = "Nome da route table publica"
}

variable "tf_rt_privada_name" {
  type        = string
  default     = "priv-route-table-terraform"
  description = "Nome da route table privada"
}

# 
# 
# ---------Ec2---------
# 
# 
#

variable "ec2_ami" {
  default     = "ami-080e1f13689e07408"
  type        = string
  description = "id imagem amazon"

}

variable "ec2_instance_type" {
  default     = "t2.micro"
  type        = string
  description = "type of instance"

}

variable "ec2_instance_name_priv" {
  default     = "priv-ec2"
  type        = string
  description = "name of pub instance"

}

variable "ec2_instance_name_pub" {
  default     = "pub-ec2"
  type        = string
  description = "name of priv instance"

}

variable "ec2_instance_key_pair_name" {
  default     = "terraform-labs"
  type        = string
  description = "name of instance key pair"

}

# 
# 
# ---------Security---------
# 
# 
#

variable "tf_sg_pub_ing" {
  default = [
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      }, {
      description      = "Acesso SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}

variable "tf_sg_pub_eg" {
  default = [
    {
      description      = "Saida HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    , {
      description      = "Saida HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    , {
      description      = "Saida dns UDPs"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    , {
      description      = "Saida dns tcp"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    , {
      description      = "Saida ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    , {
      description      = "Saida mongo"
      from_port        = 27017
      to_port          = 27017
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}


variable "tf_sg_pub_name" {
  default     = "pub-sg-terraform"
  type        = string
  description = "name of instance key pair"
}

variable "tf_sg_priv_name" {
  default     = "priv-sg-terraform"
  type        = string
  description = "name of instance key pair"
}

variable "tf_sg_priv_eg" {
  default = [
{
    description      = "Saida HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

,{
    description      = "Saida HTTPs"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

,{
    description      = "Saida dns UDPs"
    from_port        = 53
    to_port          = 53
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

,{
    description      = "Saida dns tcp"
    from_port        = 53
    to_port          = 53
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ]
}

variable "tf_net_acl_pub_ing" {
  default = [
{
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

,{
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

,{
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

,{ # Portas efemeras
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

,{
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }

,{
    protocol   = "udp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }
  ]
}

variable "tf_net_acl_pub_eg" {
  default = [
{
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  , {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  , {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  # Portas efemeras
  , {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  , {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }

  , {
    protocol   = "udp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }
  ]
}


variable "tf_net_acl_priv_ing" {
  default = [
{
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ,{
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ,{ # Portas efemeras
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ,{
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }

  ,{
    protocol   = "udp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }
  ]
}

variable "tf_net_acl_priv_eg" {
  default = [
{
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

,{
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

,{
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  # Portas efemeras
,{
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

,{
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }

,{
    protocol   = "udp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }
  ]
}
