output "ec2_pub_ip" {
  value = aws_instance.ec2-pub.public_ip
}

output "ec2_priv_ip" {
  value = aws_instance.ec2-priv.private_ip
}

