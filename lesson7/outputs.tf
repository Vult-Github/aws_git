output "Bastion_public_ip" {
  value = aws_instance.ec2_bastion.public_ip
}

output "Bastion_private_ip" {
  value = var.ec2_bastion_ip
}

output "Centre_private_ip" {
  value = var.ec2_ca_ip
}
