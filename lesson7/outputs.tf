output "Bastion_ip" {
  value = aws_instance.ec2_bastion.public_ip
}

output "Centre_ip_private" {
  value = aws_instance.ec2_centre.private_ip
}

output "Centre_dns" {
  value = aws_instance.ec2_centre.private_dns
}
