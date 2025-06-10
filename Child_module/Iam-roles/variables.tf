variable "roles" {
  description = "Mapa con los roles a crear, la clave es el nombre del rol."

  type = map(object({
    assume_role_policy_principal = string
    policy_files                 = optional(list(string), [])
  }))
}

variable "roles_to_attach_custom_policy" {
  description = "Lista de nombres de roles a los que se les debe adjuntar una política personalizada"
  type        = list(string)
}
