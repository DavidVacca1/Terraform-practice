variable "project" {
  description = "The name of a project"
  type = string
}

variable "cluster_version" {
  description = "cluster_version"
  type = string
}

variable "subnet_ids" {
  description = "Subnets for the eks cluster" # public
   
}

variable "eks_role_policy_arns" {
description = "Policy ARNs for EKS Worker Role"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
}