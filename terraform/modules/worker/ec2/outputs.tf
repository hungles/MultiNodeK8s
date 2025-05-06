output "k8_workers_public_ip" {
  value       = aws_instance.k8_worker_instance.public_ip
  description = "The public IP address of the EC2 Worker instance"
}

output "k8_workers_public_dns" {
  value = aws_instance.k8_worker_instance.public_dns
}