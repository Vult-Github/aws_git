output "Bastion_ip" {
  value = aws_instance.ec2_bastion.public_ip
}

output "db_hostname" {
  value = aws_db_instance.MariaDB_instance.address
}

output "S3_website_hostname" {
  value = "http://${aws_s3_bucket_website_configuration.s3website_conf.website_endpoint}"
}
