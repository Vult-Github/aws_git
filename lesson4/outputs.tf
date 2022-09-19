output "jenkins_url" {
  value = aws_lb.Load_balancer_jenkins.dns_name
}
