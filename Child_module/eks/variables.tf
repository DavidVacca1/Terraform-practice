variable "cluster_version" {
  type        = string
  description = "Version of the Kubernetes cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to launch EKS cluster and worker nodes"
}

variable "vpc_id" {
  type        = string
  description = "VPC to launch EKS cluster and worker nodes"
}

variable "services_cidr" {
  type        = string
  description = "CIDR block for ClusterIP services of Kubernetes cluster"
}

variable "project" {
  type        = string
  description = "Project's name"
}

variable "stage" {
  type        = string
  description = "staging name"
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

variable "coredns_version" {
  type        = string
  description = "EKS Addons version"
}

variable "vpc_cni_version" {
  type        = string
  description = "EKS Addons version"
}

variable "kube_proxy_version" {
  type        = string
  description = "EKS Addons version"
}

variable "ebs_csi_version" {
  type        = string
  description = "EKS Addons version"
}

variable "resolve_conflicts_on_update" {
  type        = string
  description = "How to resolve reflict on update, with preserve of overwrite"
}