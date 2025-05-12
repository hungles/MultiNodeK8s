output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
}

output "subnet_id" {
  value = aws_subnet.terraform_subnet.id
}