# terraform-aws-eb-windows

[![Lint Status](https://github.com/DNXLabs/terraform-aws-db-monitoring/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-db-monitoring/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-db-monitoring)](https://github.com/DNXLabs/terraform-aws-db-monitoring/blob/master/LICENSE)

This terraform module provides an Windows Elastic Beanstalk Application Resource

The module creates:
 - Cloudwatch alarms for the Aplication Load Balance (ALB)
   - alb_500_errors
   - alb_400_errors
   - alb_latency
 - Cloudwatch alarms for the Auto Scaling(ASG)
   - asg_high_cpu
 - Set a http redirect to https by default in the load balancer
 - EC2 Key pair
 - CloudWatch Event Rule resource
 - CloudWatch Event Target resource
 - Identity Access Management (IAM) roles for the Elastic Beanstalk
 - IAM roles for the Elastic Beanstalk service
 - IAM roles output
 - AutoScaling Schedule resource
   - ECS_STOP
   - ECS_START

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |