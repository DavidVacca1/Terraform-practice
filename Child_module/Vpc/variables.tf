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