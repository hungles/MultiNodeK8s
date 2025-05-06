output "alb_dns_name" {
  value = aws_lb.k8_cp_lb.dns_name
}