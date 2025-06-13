data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  account = data.aws_caller_identity.current.account_id
}

resource "null_resource" "update_aws_auth" {
  depends_on = [aws_eks_cluster.eks_cluster]

  provisioner "local-exec" {
    command = <<-EOT
    aws eks update-kubeconfig --name ${local.cluster_name} --region ${data.aws_region.current.name}
    kubectl create configmap aws-auth -n kube-system
    kubectl patch configmap/aws-auth -n kube-system --patch "$(cat <<EOF
        data:
          mapRoles: |
            - groups:
              - system:bootstrappers
              - system:nodes
              rolearn: ${aws_iam_role.eks_worker.arn}
              username: system:node:{{EC2PrivateDNSName}}

            - groups:
              - system:masters
              rolearn: ${aws_iam_role.eks.arn}  # O algún rol admin que tengas
              username: eks-admin
           
    EOF
    )"
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
  }
}
