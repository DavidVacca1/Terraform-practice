output "eks_optimized_ami" {
  value = data.aws_ami.selected_eks_optimized_ami.id
}
