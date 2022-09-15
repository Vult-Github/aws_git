output "instance_ip_addr" {
  value = aws_lb.Load_balancer_jenkins.dns_name
}
