#EKS Cluster Role

resource "aws_iam_role" "eks" {
  name = "${var.project_name}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policies" {
  for_each = toset(var.eks_role_policy_arns)
  policy_arn = each.value
  role = aws_iam_role.eks.name
  
}

# EKS Worker nodes
resource "aws_iam_role" "eks_worker" {
  name = "${var.project_name}-eks-worker-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume.json 

}

resource "aws_iam_role_policy_attachment" "worker_policies" {
  for_each = toset(var.worker_role_policy_arns)
  policy_arn = each.value
  role = aws_iam_role.eks_worker.name
  
}


