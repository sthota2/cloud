output "alb_dns_name" {
  value       = aws_alb.my_alb.dns_name
  description = "The Domain Name of the load balancer"

}
