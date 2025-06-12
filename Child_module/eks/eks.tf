resource "aws_eks_cluster" "eks_cluster" {
  name     = local.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks.arn

  kubernetes_network_config {
    service_ipv4_cidr = var.k8s_service_cidr
  }


  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids              = var.Public_subnets
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policies
  ]

  tags = {
    Name  = local.cluster_name
    Owner = local.owner_tag
  }
}

resource "aws_security_group" "k8scluster-sg" {
  name        = "eks-cluster-sg-${local.cluster_name}"
  description = "Main Security Group of EKS cluster"
  vpc_id      = var.vpc_id

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    "Name"                                        = "eks-cluster-sg-${local.cluster_name}"
  }
}
