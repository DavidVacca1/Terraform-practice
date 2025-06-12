output "vpc_id" {
  value = aws_vpc.Vpc_eks.id
}

output "Public_subnet_ids" {
  description = "IDs de las subnets públicas para el EKS"
  value       = [for subnet in aws_subnet.Public_subnets : subnet.id]
}

output "Private_subnet_ids" {
  description = "IDs de las subnets públicas para el EKS"
  value       = [for subnet in aws_subnet.Private_subnets : subnet.id]
}
