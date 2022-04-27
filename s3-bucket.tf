locals {
  partition = join("", data.aws_partition.current.*.partition)
  name_lowercase = lower(var.name)
  bucket_elb_logs_name = var.s3_bucket_elb_logs_name == "" ? "${var.environment}-eb-elb-logs-${local.name_lowercase}" : var.s3_bucket_elb_logs_name
}

data "aws_iam_policy_document" "elb_logs" {
  count = var.s3_bucket_elb_logs_create && var.eb_tier == "WebServer" && var.environment_type == "LoadBalanced" && var.loadbalancer_type != "network" && !var.loadbalancer_is_shared ? 1 : 0

  statement {
    sid = ""

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:${local.partition}:s3:::${local.bucket_elb_logs_name}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [join("", data.aws_elb_service_account.current.*.arn)]
    }

    effect = "Allow"
  }
}

resource "aws_s3_bucket" "elb_logs" {
  count         = var.s3_bucket_elb_logs_create && var.eb_tier == "WebServer" && var.environment_type == "LoadBalanced" && var.loadbalancer_type != "network" && !var.loadbalancer_is_shared ? 1 : 0
  bucket        = "${local.bucket_elb_logs_name}"
  acl           = "private"
  force_destroy = var.s3_bucket_elb_logs_force_destroy
  policy        = join("", data.aws_iam_policy_document.elb_logs.*.json)

  dynamic "server_side_encryption_configuration" {
    for_each = var.s3_bucket_elb_logs_encryption_enabled ? ["true"] : []

    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }
  }

  versioning {
    enabled = var.s3_bucket_elb_logs_versioning_enabled
  }

  dynamic "logging" {
    for_each = var.s3_bucket_elb_logs_access_log_bucket_name != "" ? [1] : []
    content {
      target_bucket = var.s3_bucket_elb_logs_access_log_bucket_name
      target_prefix = "logs/${local.name_lowercase}/"
    }
  }
}