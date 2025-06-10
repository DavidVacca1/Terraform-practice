output "vpc_id" {
  value = aws_vpc.Vpc_eks.id
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas para el EKS"
  value       = [for subnet in aws_subnet.Public_eks_subnets : subnet.id]
}

output "private_subnet_ids" {
  description = "IDs de las subnets públicas para el EKS"
  value       = [for subnet in aws_subnet.Private_eks_subnets : subnet.id]
}
