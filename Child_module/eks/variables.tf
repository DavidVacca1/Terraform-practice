variable "project_name" {
  description = "The name of a project"
  type        = string
}

variable "stage" {
  type        = string
  description = "staging name"
}

variable "cluster_version" {
  description = "cluster_version"
  type        = string
}

variable "Public_subnets" {
  type        = list(string)
  description = "Lista de bloques CIDR para las subnets públicas"
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

variable "worker_role_policy_arns" {
  description = "Policy ARNs for EKS Worker Role"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

variable "k8s_service_cidr" {
  type    = string
  default = "The service IPv4 CIDR for the Kubernetes cluster"

}

variable "vpc_id" {
  type = string

}

variable "workers_desired" {
  type        = number
  description = "Desired number of worker nodes"
}

variable "workers_min" {
  type        = number
  description = "Min number of worker nodes"
}

variable "workers_max" {
  type        = number
  description = "Max number of worker nodes"
}

variable "instance_type" {
  type        = string
  description = "Worker nodes instance type"
}

variable "volume_type" {
  type        = string
  description = "Worker nodes launch template volume type"
}

variable "iam_role_names" {
  type        = list(string)
  description = "EKS cluster iam role names, including admin access and all applications access"
}

variable "health_check_type" {
  type        = string
  description = "Woker nodes ASG health check type"
}
