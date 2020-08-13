# terraform-aws-eb-windows

Terraform-aws-eb-windows is a module that provides an Windows Elastic Beanstalk Application Resource 

This module requires:
 - Terraform Version >=0.12.20

The module creates:
 - Cloudwatch alarms for the Aplication Load Balance (ALB)
   - alb_500_errors
   - alb_400_errors
   - alb_latency
 - Cloudwatch alarms for the Auto Scaling(ASG)
   - asg_high_cpu
 - EC2 Key pair
 - CloudWatch Event Rule resource
 - CloudWatch Event Target resource
 - Identity Access Management (IAM) roles for the Elastic Beanstalk
 - IAM roles for the Elastic Beanstalk service
 - AutoScaling Schedule resource
   - ECS_STOP
   - ECS_START
    

[![Lint Status](https://github.com/DNXLabs/terraform-aws-db-monitoring/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-db-monitoring/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-db-monitoring)](https://github.com/DNXLabs/terraform-aws-db-monitoring/blob/master/LICENSE)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |