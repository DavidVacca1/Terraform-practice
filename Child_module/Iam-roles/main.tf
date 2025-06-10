# Crea un rol de AWS IAM para cada rol que tengas en la variable "roles"
resource "aws_iam_role" "Role" {
  for_each = var.roles # Aquí toma cada rol que definiste en "roles"

  name = each.key # El nombre del rol es la palabra que está antes de los dos puntos, por ejemplo:
  # "DeveloperDevAccessRole" o "DevopsDevAccessRole"

  # Aquí definimos quién puede usar este rol, es como dar permiso a alguien para ponerse este rol.
  assume_role_policy = templatefile(
    "${path.module}/assume_role_policy.tpl.json", # Archivo que tiene las reglas para esto
    {
      principal_arn = each.value.assume_role_policy_principal
      # Aquí pone el ARN que definiste para cada rol, por ejemplo:
      # Para DeveloperDevAccessRole es "arn:aws:iam::029864681999:role/Devops_Engineer_role"
      # Para DevopsDevAccessRole también es "arn:aws:iam::029864681999:role/Devops_Engineer_role"
    }
  )
}

# Crea una política (un conjunto de reglas) para cada rol que tenga archivos de políticas
resource "aws_iam_policy" "Policy" {
  for_each = {
    for role_name, role in var.roles :
    role_name => role
    if contains(keys(role), "policy_files") && length(role.policy_files) > 0
    # Solo crea política para roles que tengan al menos un archivo de políticas, como:
    # DeveloperDevAccessRole que tiene "policies/DeveloperDevAccesRole.json"
    # DevopsDevAccessRole que tiene "policies/DevopsDevAccesRole.json"
  }

  name = "${each.key}-policy"
  # El nombre de la política será el nombre del rol más "-policy"
  # Ejemplo: "DeveloperDevAccessRole-policy", "DevopsDevAccessRole-policy"

  description = "Custom policy for ${each.key}"
  # Explicación sencilla para saber para qué es la política

  policy = file("${path.module}/policies/${each.key}.json")
  # Lee el archivo de reglas para esta política
  # Por ejemplo: lee "policies/DeveloperDevAccesRole.json" para DeveloperDevAccessRole
  # y "policies/DevopsDevAccesRole.json" para DevopsDevAccessRole
}

# Une o conecta la política creada al rol correspondiente
resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  for_each = toset(var.roles_to_attach_custom_policy)
  # Para cada nombre de rol que quieres conectar con su política personalizada
  # Aquí usas la lista:
  # ["DeveloperDevAccessRole", "DevopsDevAccessRole"]

  policy_arn = aws_iam_policy.Policy[each.key].arn
  # Toma la "dirección" (ARN) de la política creada para ese rol

  role = aws_iam_role.Role[each.key].name
  # Toma el nombre del rol para conectar la política
}
