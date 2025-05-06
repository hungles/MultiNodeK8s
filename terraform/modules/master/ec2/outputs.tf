output "k8_masters_public_ip" {
  value       = aws_instance.k8_master_instance.public_ip
  description = "The public IP address of the EC2 Master instance"
}

output "k8_masters_public_dns" {
  value = aws_instance.k8_master_instance.public_dns
}

output "instance_id" {
  value = aws_instance.k8_master_instance.id
}