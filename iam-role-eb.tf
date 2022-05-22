resource "aws_iam_instance_profile" "eb" {
  name_prefix = "eb-ec2-role-"
  role        = aws_iam_role.eb.name
}

resource "aws_iam_role" "eb" {
  name_prefix = "eb-ec2-role-"
  path        = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eb_worker_tier" {
  for_each   = { for policy in local.aws_iam_role_policies_attachment : policy.name => policy }
  role       = aws_iam_role.eb.name
  policy_arn = each.value.policy_arn
}

locals {
  default_iam_role_policy_attachment_to_instance = [
    {
      name : "AWSElasticBeanstalkWorkerTier",
      policy_arn : "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
    },
    {
      name : "AmazonSSMFullAccess",
      policy_arn : "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    },
    {
      name : "AWSElasticBeanstalkMulticontainerDocker",
      policy_arn : "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
    },
    {
      name : "AWSElasticBeanstalkWebTier",
      policy_arn : "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
    }
  ]

  aws_iam_role_policies_attachment = concat(local.default_iam_role_policy_attachment_to_instance, var.iam_role_policy_attachment_to_instance)
}
