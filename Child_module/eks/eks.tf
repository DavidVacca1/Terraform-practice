
resource "aws_eks_cluster" "eks_cluster" {
  name = var.project
  version = var.cluster_version
  role_arn = aws_iam_role.eks.arn

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true

  }

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true

    subnet_ids = [
      aws_subnet.az1.id,
      aws_subnet.az2.id,
      aws_subnet.az3.id,
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

