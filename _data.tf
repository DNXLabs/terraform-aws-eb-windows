data "aws_region" "current" {}
data "aws_iam_account_alias" "current" {
  count = var.ignore_iam_account_alias ? 0 : 1
}
data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_elb_service_account" "current" {
  count = var.eb_tier == "WebServer" && var.environment_type == "LoadBalanced" ? 1 : 0
}