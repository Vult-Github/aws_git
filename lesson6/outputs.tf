output "ec2_suba_ip" {
  value = aws_instance.ec2_bastion.public_ip
}

output "db_hostname" {
  value = aws_db_instance.MariaDB_instance.address
}
