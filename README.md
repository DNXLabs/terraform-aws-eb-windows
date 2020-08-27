# terraform-aws-eb-windows

[![Lint Status](https://github.com/DNXLabs/terraform-aws-eb-windows/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-eb-windows/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-eb-windows)](https://github.com/DNXLabs/terraform-aws-eb-windows/blob/master/LICENSE)

This terraform module provides an Windows Elastic Beanstalk Application Resource

The following resources will be created:
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
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ad\_directory\_id | ID of directory from AWS Simple AD | `string` | `""` | no |
| ad\_directory\_ip1 | AD Directory first IP address | `string` | `""` | no |
| ad\_directory\_ip2 | AD second IP address | `string` | `""` | no |
| ad\_directory\_name | Active Directory Name (leave it blank to disable join domain automation) | `string` | `""` | no |
| alarm\_alb\_400\_errors\_threshold | Max threshold of HTTP 4000 errors allowed in a 5 minutes interval (use 0 to disable this alarm) | `number` | `10` | no |
| alarm\_alb\_500\_errors\_threshold | Max threshold of HTTP 500 errors allowed in a 5 minutes interval (use 0 to disable this alarm) | `number` | `10` | no |
| alarm\_alb\_latency\_anomaly\_threshold | ALB Latency anomaly detection width (use 0 to disable this alarm) | `number` | `4` | no |
| alarm\_asg\_high\_cpu\_threshold | Max threshold average CPU percentage allowed in a 2 minutes interval (use 0 to disable this alarm) | `number` | `80` | no |
| alarm\_sns\_topics | Alarm topics to create and alert on ECS service metrics. Leaving empty disables all alarms. | `list` | `[]` | no |
| asg\_max | Max number of instances for autoscaling group | `number` | `4` | no |
| asg\_min | Min number of instances for autoscaling group | `number` | `1` | no |
| autoscaling\_default\_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `300` | no |
| autoscaling\_health\_check\_grace\_period | The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service | `number` | `300` | no |
| certificate\_arn | n/a | `any` | n/a | yes |
| cloudwatch\_logs\_retention | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `120` | no |
| eb\_application\_name | EB application name (empty value will create an application) | `string` | `""` | no |
| eb\_solution\_stack\_name | Stack name passed to ElasticBeanstalk | `string` | `"64bit Windows Server 2019 v2.5.2 running IIS 10.0"` | no |
| enable\_schedule | Enables schedule to shut down and start up instances outside business hours | `bool` | `false` | no |
| environment | Name of this environment | `string` | `"dev"` | no |
| hosted\_zone | Hosted zone to create the hostname | `string` | `""` | no |
| hostname | Hostname to create on route53 pointing to the EB CNAME (leave empty to prevent creation) | `string` | `""` | no |
| instance\_type\_1 | Instance type for ECS workers (first priority) | `any` | n/a | yes |
| instance\_type\_2 | Instance type for ECS workers (second priority) | `any` | n/a | yes |
| instance\_type\_3 | Instance type for ECS workers (third priority) | `any` | n/a | yes |
| key\_name | Defines a SSH keypair to access EB instances (leave empty to create one) | `string` | `""` | no |
| name | Name for this application | `any` | n/a | yes |
| on\_demand\_base\_capacity | You can designate a base portion of your total capacity as On-Demand. As the group scales, per your settings, the base portion is provisioned first, while additional On-Demand capacity is percentage-based. | `number` | `0` | no |
| on\_demand\_percentage | Percentage of on-demand intances vs spot | `number` | `100` | no |
| private\_subnet\_ids | List of private subnet IDs for instances | `list` | n/a | yes |
| public\_subnet\_ids | List of public subnet IDs for ALB | `list` | n/a | yes |
| schedule\_cron\_start | Cron expression to define when to trigger a start of the auto-scaling group. E.g. '0 20 \* \* \*' to start at 8pm GMT time | `string` | `""` | no |
| schedule\_cron\_stop | Cron expression to define when to trigger a stop of the auto-scaling group. E.g. '0 10 \* \* \*' to stop at 10am GMT time | `string` | `""` | no |
| secure\_subnet\_ids | List of secure subnet IDs for EFS | `list` | n/a | yes |
| security\_group\_ids | Extra security groups for instances | `list` | `[]` | no |
| stickiness\_enabled | Route requests from the same client to the same target | `bool` | `false` | no |
| stickiness\_expiration | Cookie expiration period, in seconds | `number` | `86400` | no |
| vpc\_id | VPC ID to deploy the  cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| eb\_all\_settings | n/a |
| eb\_environment\_id | n/a |
| iam\_role\_eb\_arn | ARN for EB IAM role |
| iam\_role\_eb\_name | Name of EB IAM role |
| ssm\_association\_join\_domain\_automation | n/a |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-eb-windows/blob/master/LICENSE) for full details.