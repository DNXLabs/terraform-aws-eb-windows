resource "aws_cloudwatch_event_rule" "automation" {
  count = var.ad_directory_name == "" ? 0 : 1

  name          = "eb-automation-${var.environment}-${var.name}"
  description   = "EB instance join a domain"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance Launch Successful"
  ],
  "detail": {
    "AutoScalingGroupName": [
      "${aws_elastic_beanstalk_environment.env.autoscaling_groups[0]}"
    ]
  }
}
PATTERN
}



resource "aws_cloudwatch_event_target" "automation" {
  count     = var.ad_directory_name == "" ? 0 : 1
  arn       = "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:automation-definition/${aws_ssm_document.automation[0].name}:$DEFAULT"
  role_arn  = aws_iam_role.event[0].arn
  rule      = aws_cloudwatch_event_rule.automation[0].name
  target_id = "eb-automation-${var.environment}-${var.name}"
}
