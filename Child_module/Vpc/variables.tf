variable "vpc_cidr" {
  type = string

}

variable "Public_eks_subnets" {
  type        = list(string)
  description = "Lista de bloques CIDR para las subnets públicas"
}

variable "Private_eks_subnets" {
  type        = list(string)
  description = "Lista de bloques CIDR para las subnets privadas"

}
