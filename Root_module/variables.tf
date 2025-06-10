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
