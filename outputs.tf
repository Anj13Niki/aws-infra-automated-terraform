output "loadbalancers" {
    value = aws_alb.webalb.dns_name
}

output "public_ip1" {
  value = aws_instance.web_instance1.public_ip
}

output "public_ip2" {
  value = aws_instance.web_instance2.public_ip
}