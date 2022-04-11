locals {
    partition = join("", data.aws_partition.current.*.partition)
    name      = lower(var.name)
}

data "aws_iam_policy_document" "elb_logs" {
  count = var.eb_tier == "WebServer" && var.environment_type == "LoadBalanced" && var.loadbalancer_type != "network" && !var.loadbalancer_is_shared ? 1 : 0

  statement {
    sid = ""

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:${local.partition}:s3:::${local.name}-eb-loadbalancer-logs/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [join("", data.aws_elb_service_account.main.*.arn)]
    }

    effect = "Allow"
  }
}

resource "aws_s3_bucket" "elb_logs" {
  count         = var.eb_tier == "WebServer" && var.environment_type == "LoadBalanced" && var.loadbalancer_type != "network" && !var.loadbalancer_is_shared ? 1 : 0
  bucket        = "${local.name}-eb-loadbalancer-logs"
  acl           = "private"
  force_destroy = var.s3_force_destroy
  policy        = join("", data.aws_iam_policy_document.elb_logs.*.json)

  dynamic "server_side_encryption_configuration" {
    for_each = var.s3_bucket_encryption_enabled ? ["true"] : []

    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }
  }

  versioning {
    enabled = var.s3_bucket_versioning_enabled
  }

  dynamic "logging" {
    for_each = var.s3_bucket_access_log_bucket_name != "" ? [1] : []
    content {
      target_bucket = var.s3_bucket_access_log_bucket_name
      target_prefix = "logs/${local.name}/"
    }
  }
}