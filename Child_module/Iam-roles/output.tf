output "policy_arns" {
  value = { for key, policy in aws_iam_policy.Policy : key => policy.arn }
}

output "role_names" {
  value = { for key, role in aws_iam_role.Role : key => role.name }
}

