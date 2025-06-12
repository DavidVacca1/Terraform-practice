variable "region" {
  default = "us-east-1"
}

variable "roles" {
  description = "Mapa de roles IAM a crear, con principal y archivos de políticas."
  type = map(object({
    assume_role_policy_principal = string
    policy_files                 = optional(list(string), [])
  }))
}

variable "roles_to_attach_custom_policy" {
  description = "Lista de nombres de roles a los que se les debe adjuntar una política personalizada."
  type        = list(string)
}

variable "vpc_cidr" {
  type = string

}
variable "cidr_block" {
  type = string

}
variable "Public_subnets" {
  type        = list(string)
  description = "Lista de bloques CIDR para las subnets públicas"
}

variable "Private_subnets" {
  type        = list(string)
  description = "Lista de bloques CIDR para las subnets privadas"

}

variable "project_name" {
  description = "The name of a project"
  type        = string
}

variable "cluster_version" {
  description = "cluster_version"
  type = string
}

variable "k8s_service_cidr" {
  type = string
  default = "The service IPv4 CIDR for the Kubernetes cluster"
  
}