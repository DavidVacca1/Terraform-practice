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

resource "aws_security_group_rule" "allow_ingress" {
  depends_on        = [aws_security_group.worker_nodes_sg]
  security_group_id = aws_security_group.k8scluster-sg.id

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.worker_nodes_sg.id

}

resource "aws_security_group_rule" "allow_egress_443" {
  depends_on        = [aws_security_group.worker_nodes_sg]
  security_group_id = aws_security_group.k8scluster-sg.id

  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.worker_nodes_sg.id
}

resource "aws_security_group_rule" "allow_egress_tcp" {
  depends_on        = [aws_security_group.worker_nodes_sg]
  security_group_id = aws_security_group.k8scluster-sg.id

  type                     = "egress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.worker_nodes_sg.id
}
