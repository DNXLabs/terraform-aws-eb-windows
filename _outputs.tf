output "iam_role_eb_arn" {
  value       = aws_iam_role.eb.arn
  description = "ARN for EB IAM role"
}

output "iam_role_eb_name" {
  value       = aws_iam_role.eb.name
  description = "Name of EB IAM role"
}

output "eb_environment_id" {
  value = aws_elastic_beanstalk_environment.env.id
}

output "eb_all_settings" {
  value = aws_elastic_beanstalk_environment.env.all_settings
}
