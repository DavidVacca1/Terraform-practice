#roles variables
roles = {
  DeveloperDevAccessRole = {
    assume_role_policy_principal = "arn:aws:iam::029864681999:role/Devops_Engineer_role"
    policy_files                 = ["policies/DeveloperDevAccesRole.json"]
  }
  DevopsDevAccessRole = {
    assume_role_policy_principal = "arn:aws:iam::029864681999:role/Devops_Engineer_role"
    policy_files                 = ["policies/DevopsDevAccesRole.json"]
  }
}

roles_to_attach_custom_policy = [
  "DeveloperDevAccessRole",
  "DevopsDevAccessRole"
]

#
