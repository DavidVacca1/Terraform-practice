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

#Vpc

vpc_cidr = "10.0.0.0/16"

Public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
Private_subnets = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]


# route tables

cidr_block = "0.0.0.0/0"

# eks
project_name = "David_Practice"
cluster_version = "1.30"
k8s_service_cidr = "10.10.0.0/16"

