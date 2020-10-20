data "aws_region" "current" {}
data "aws_iam_account_alias" "current" {
  count = "${var.ignore_iam_account_alias ? 0 : 1}"
}
data "aws_caller_identity" "current" {}
