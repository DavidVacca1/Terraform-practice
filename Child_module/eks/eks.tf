resource "aws_eks_cluster" "eks_cluster" {
  name     = local.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks.arn

  kubernetes_network_config {
    service_ipv4_cidr = var.k8s_service_cidr
  }
  bootstrap_self_managed_addons = true

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

#version mas usada

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "coredns"
  addon_version               = var.coredns_version
  resolve_conflicts_on_update = var.resolve_conflicts_on_update
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "vpc-cni"
  addon_version               = var.vpc_cni_version
  resolve_conflicts_on_update = var.resolve_conflicts_on_update
}


resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "kube-proxy"
  addon_version               = var.kube_proxy_version
  resolve_conflicts_on_update = var.resolve_conflicts_on_update
}

# resource "aws_eks_addon" "ebs_csi" {
#   cluster_name                = aws_eks_cluster.eks_cluster.name
#   addon_name                  = "aws-ebs-csi-driver"
#   addon_version               = var.ebs_csi_version
#   resolve_conflicts_on_update = var.resolve_conflicts_on_update
# }
