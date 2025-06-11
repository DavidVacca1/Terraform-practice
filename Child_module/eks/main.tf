resource "aws_iam_role" "eks" {
  name =  "${local.env}-${local.eks_name}-eks-cluster"

  assume_role_policy = jsondecode( {  
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "eks.amazonaws.com"
            }
        }
    ]
})
}