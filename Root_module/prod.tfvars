#roles variables
roles = {
  DeveloperProdAccessRole = {
    assume_role_policy_principal = "arn:aws:iam::029864681999:role/Devops_Engineer_role"
    policy_files                 = ["policies/DeveloperProdAccesRole.json"]
  }
  DevopsProdAccessRole = {
    assume_role_policy_principal = "arn:aws:iam::029864681999:role/Devops_Engineer_role"
    policy_files                 = ["policies/DevopsProdAccesRole.json"]
  }
}

roles_to_attach_custom_policy = [
  "DeveloperProdAccessRole",
  "DevopsProdAccessRole"
]

#
