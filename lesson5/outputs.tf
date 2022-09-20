output "ec2_suba_ip" {
  value = aws_instance.ec2_jenkins_subA.public_ip
}
/*
output "ec2_subb_ip" {
  value = var.environment_type == "Prod" ? aws_instance.ec2_jenkins_subB[count.index].public_ip : null
}
*/
