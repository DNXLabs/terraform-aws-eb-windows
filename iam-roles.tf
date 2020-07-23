
data "aws_iam_policy_document" "event" {
  count = var.ad_directory_name == "" ? 0 : 1
  statement {
    effect    = "Allow"
    actions   = ["ssm:StartAutomationExecution"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "event_trust" {
  count = var.ad_directory_name == "" ? 0 : 1
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "event" {
  count              = var.ad_directory_name == "" ? 0 : 1
  name_prefix        = "eb-automation-${var.environment}-${var.name}-"
  assume_role_policy = data.aws_iam_policy_document.event_trust[0].json
}

resource "aws_iam_role_policy" "event" {
  count       = var.ad_directory_name == "" ? 0 : 1
  name_prefix = "eb-automation-${var.environment}-${var.name}-"
  policy      = data.aws_iam_policy_document.event[0].json
  role        = aws_iam_role.event[0].name
}
