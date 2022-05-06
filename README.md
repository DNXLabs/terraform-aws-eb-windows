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
| terraform | >= 0.13.0 |

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
| additional\_settings | Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html | <pre>list(object({<br>    namespace = string<br>    name      = string<br>    value     = string<br>  }))</pre> | `[]` | no |
| alarm\_alb\_400\_errors\_threshold | Max threshold of HTTP 4000 errors allowed in a 5 minutes interval (use 0 to disable this alarm) | `number` | `10` | no |
| alarm\_alb\_500\_errors\_threshold | Max threshold of HTTP 500 errors allowed in a 5 minutes interval (use 0 to disable this alarm) | `number` | `10` | no |
| alarm\_alb\_latency\_anomaly\_threshold | ALB Latency anomaly detection width (use 0 to disable this alarm) | `number` | `4` | no |
| alarm\_asg\_high\_cpu\_threshold | Max threshold average CPU percentage allowed in a 2 minutes interval (use 0 to disable this alarm) | `number` | `80` | no |
| alarm\_sns\_topics | Alarm topics to create and alert on ECS service metrics. Leaving empty disables all alarms. | `list` | `[]` | no |
| application\_port | Port application is listening on | `number` | `80` | no |
| application\_subnets | List of subnets to place EC2 instances | `list(string)` | n/a | yes |
| asg\_max | Max number of instances for autoscaling group | `number` | `4` | no |
| asg\_min | Min number of instances for autoscaling group | `number` | `1` | no |
| associate\_public\_ip\_address | Whether to associate public IP addresses to the instances | `bool` | `false` | no |
| associated\_security\_group\_ids | A list of IDs of Security Groups to associate the created resource with, in addition to the created security group.<br>These security groups will not be modified and, if `create_security_group` is `false`, must have rules providing the desired access. | `list(string)` | `[]` | no |
| autoscaling\_default\_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `300` | no |
| autoscaling\_health\_check\_grace\_period | The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service | `number` | `300` | no |
| availability\_zone\_selector | Availability Zone selector | `string` | `"Any 2"` | no |
| cloudwatch\_logs\_retention | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `120` | no |
| coudwatch\_environment\_metrics | Environment metrics to be collected from beanstalk to cloudwatch | `map(number)` | `{}` | no |
| coudwatch\_instance\_metrics | Instance metrics to be collected from beanstalk to cloudwatch | `map(number)` | `{}` | no |
| create\_security\_group | Set `true` to create and configure a Security Group for the cluster. | `bool` | `true` | no |
| deployment\_batch\_size | Percentage or fixed number of Amazon EC2 instances in the Auto Scaling group on which to simultaneously perform deployments. Valid values vary per deployment\_batch\_size\_type setting | `number` | `100` | no |
| deployment\_batch\_size\_type | The type of number that is specified in deployment\_batch\_size\_type | `string` | `"Percentage"` | no |
| deployment\_ignore\_health\_check | Do not cancel a deployment due to failed health checks | `bool` | `false` | no |
| deployment\_policy | Use the DeploymentPolicy option to set the deployment type. The following values are supported: `AllAtOnce`, `Rolling`, `RollingWithAdditionalBatch`, `Immutable`, `TrafficSplitting` | `string` | `"Rolling"` | no |
| deployment\_timeout | Number of seconds to wait for an instance to complete executing commands | `number` | `600` | no |
| description | Short description of the Environment | `string` | `""` | no |
| eb\_application\_name | EB application name (empty value will create an application) | `string` | `""` | no |
| eb\_solution\_stack\_name | Stack name passed to ElasticBeanstalk | `any` | n/a | yes |
| eb\_tier | Elastic Beanstalk Environment tier, 'WebServer' or 'Worker' | `string` | `"WebServer"` | no |
| eb\_version\_label | Elastic Beanstalk Application version to deploy | `string` | `""` | no |
| eb\_wait\_for\_ready\_timeout | The maximum duration to wait for the Elastic Beanstalk Environment to be in a ready state before timing out | `string` | `"20m"` | no |
| egress\_rules | How long to wait for the security group to be created. | <pre>list(object({<br>    from_port   = string<br>    to_port     = string<br>    protocol    = string<br>    description = string<br>    cidr_blocks = list(string)<br>    self        = string<br>  }))</pre> | `[]` | no |
| elb\_scheme | Specify `internal` if you want to create an internal load balancer in your Amazon VPC so that your Elastic Beanstalk application cannot be accessed from outside your Amazon VPC | `string` | `"public"` | no |
| enable\_log\_publication\_control | Copy the log files for your application's Amazon EC2 instances to the Amazon S3 bucket associated with your application | `bool` | `false` | no |
| enable\_schedule | Enables schedule to shut down and start up instances outside business hours | `bool` | `false` | no |
| enable\_spot\_instances | Enable Spot Instance requests for your environment | `bool` | `false` | no |
| enable\_stream\_logs | Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in your environment | `bool` | `false` | no |
| environment | Name of this environment | `string` | `"dev"` | no |
| environment\_type | Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `loadbalancer_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments) | `string` | `"LoadBalanced"` | no |
| health\_streaming\_delete\_on\_terminate | Whether to delete the log group when the environment is terminated. If false, the health data is kept RetentionInDays days. | `bool` | `false` | no |
| health\_streaming\_enabled | For environments with enhanced health reporting enabled, whether to create a group in CloudWatch Logs for environment health and archive Elastic Beanstalk environment health data. For information about enabling enhanced health, see aws:elasticbeanstalk:healthreporting:system. | `bool` | `false` | no |
| health\_streaming\_retention\_in\_days | The number of days to keep the archived health data before it expires. | `number` | `7` | no |
| healthcheck\_healthy\_threshold\_count | The number of consecutive successful requests before Elastic Load Balancing changes the instance health status | `number` | `3` | no |
| healthcheck\_httpcodes\_to\_match | List of HTTP codes that indicate that an instance is healthy. Note that this option is only applicable to environments with a network or application load balancer | `list(string)` | <pre>[<br>  "200",<br>  "301"<br>]</pre> | no |
| healthcheck\_interval | The interval of time, in seconds, that Elastic Load Balancing checks the health of the Amazon EC2 instances of your application | `number` | `10` | no |
| healthcheck\_timeout | The amount of time, in seconds, to wait for a response during a health check. Note that this option is only applicable to environments with an application load balancer | `number` | `5` | no |
| healthcheck\_unhealthy\_threshold\_count | The number of consecutive unsuccessful requests before Elastic Load Balancing changes the instance health status | `number` | `3` | no |
| healthcheck\_url | Application Health Check URL. Elastic Beanstalk will call this URL to check the health of the application running on EC2 instances | `string` | `"/"` | no |
| hosted\_zone | Hosted zone to create the hostname | `string` | `""` | no |
| hostnames | Hostname to create on route53 pointing to the EB CNAME (leave empty to prevent creation) | `list(string)` | `[]` | no |
| http\_listener\_enabled | Enable port 80 (http) | `bool` | `true` | no |
| ignore\_iam\_account\_alias | Disables data source for iam\_account\_alias used on cloudwatch alarms | `bool` | `false` | no |
| ingress\_rules | How long to wait for the security group to be created. | <pre>list(object({<br>    from_port   = string<br>    to_port     = string<br>    protocol    = string<br>    description = string<br>    cidr_blocks = list(string)<br>    self        = string<br>  }))</pre> | `[]` | no |
| instance\_refresh\_enabled | Enable weekly instance replacement. | `bool` | `false` | no |
| instance\_type | Instance type | `string` | `"t2.micro"` | no |
| key\_name | Defines a SSH keypair to access EB instances (leave empty to create one) | `string` | `""` | no |
| loadbalancer\_certificate\_arn | Load Balancer SSL certificate ARN. The certificate must be present in AWS Certificate Manager | `string` | `""` | no |
| loadbalancer\_is\_shared | Flag to create a shared application loadbalancer. Only when loadbalancer\_type = "application" https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-cfg-alb-shared.html | `bool` | `false` | no |
| loadbalancer\_managed\_security\_group | Load balancer managed security group | `string` | `""` | no |
| loadbalancer\_security\_groups | Load balancer security groups | `list(string)` | `[]` | no |
| loadbalancer\_ssl\_policy | Specify a security policy to apply to the listener. This option is only applicable to environments with an application load balancer | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| loadbalancer\_subnets | List of subnets to place Elastic Load Balancer | `list(string)` | `[]` | no |
| loadbalancer\_type | Load Balancer type, e.g. 'application' or 'network' | `string` | `"application"` | no |
| logs\_delete\_on\_terminate | Whether to delete the log groups when the environment is terminated. If false, the logs are kept RetentionInDays days | `bool` | `false` | no |
| logs\_retention\_in\_days | The number of days to keep log events before they expire. | `number` | `7` | no |
| name | Name for this application | `any` | n/a | yes |
| on\_demand\_base\_capacity | You can designate a base portion of your total capacity as On-Demand. As the group scales, per your settings, the base portion is provisioned first, while additional On-Demand capacity is percentage-based. | `number` | `0` | no |
| on\_demand\_percentage | Percentage of on-demand intances vs spot | `number` | `100` | no |
| preferred\_start\_time | Configure a maintenance window for managed actions in UTC | `string` | `"Sun:10:00"` | no |
| rolling\_update\_enabled | Whether to enable rolling update | `bool` | `true` | no |
| rolling\_update\_type | `Health` or `Immutable`. Set it to `Immutable` to apply the configuration change to a fresh group of instances | `string` | `"Health"` | no |
| root\_volume\_size | The size of the EBS root volume | `number` | `30` | no |
| root\_volume\_type | The type of the EBS root volume | `string` | `"gp2"` | no |
| s3\_bucket\_access\_log\_bucket\_name | Name of the S3 bucket where s3 access log will be sent to | `string` | `""` | no |
| s3\_bucket\_encryption\_enabled | When set to 'true' the resource will have aes256 encryption enabled by default | `bool` | `true` | no |
| s3\_bucket\_versioning\_enabled | When set to 'true' the s3 origin bucket will have versioning enabled | `bool` | `true` | no |
| s3\_force\_destroy | Force destroy the S3 bucket for load balancer logs | `bool` | `false` | no |
| schedule\_cron\_start | Cron expression to define when to trigger a start of the auto-scaling group. E.g. '0 20 \* \* \*' to start at 8pm GMT time | `string` | `""` | no |
| schedule\_cron\_stop | Cron expression to define when to trigger a stop of the auto-scaling group. E.g. '0 10 \* \* \*' to stop at 10am GMT time | `string` | `""` | no |
| security\_group\_description | The description to assign to the created Security Group.<br>Warning: Changing the description causes the security group to be replaced. | `string` | `"Security Group for ElasticBean Stalk"` | no |
| security\_group\_name | The name to assign to the created security group. Must be unique within the VPC.<br>If not provided, will be derived from the `null-label.context` passed in. | `string` | n/a | yes |
| shared\_loadbalancer\_arn | ARN of the shared application load balancer. Only when loadbalancer\_type = "application". | `string` | `""` | no |
| spot\_fleet\_on\_demand\_above\_base\_percentage | The percentage of On-Demand Instances as part of additional capacity that your Auto Scaling group provisions beyond the SpotOnDemandBase instances. This option is relevant only when enable\_spot\_instances is true. | `number` | `-1` | no |
| spot\_fleet\_on\_demand\_base | The minimum number of On-Demand Instances that your Auto Scaling group provisions before considering Spot Instances as your environment scales up. This option is relevant only when enable\_spot\_instances is true. | `number` | `0` | no |
| spot\_max\_price | The maximum price per unit hour, in US$, that you're willing to pay for a Spot Instance. This option is relevant only when enable\_spot\_instances is true. Valid values are between 0.001 and 20.0 | `number` | `-1` | no |
| stickiness\_enabled | Route requests from the same client to the same target | `bool` | `false` | no |
| stickiness\_expiration | Cookie expiration period, in seconds | `number` | `86400` | no |
| update\_level | The highest level of update to apply with managed platform updates | `string` | `"minor"` | no |
| updating\_max\_batch | Maximum number of instances to update at once | `number` | `1` | no |
| updating\_min\_in\_service | Minimum number of instances in service during update | `number` | `1` | no |
| vpc\_id | VPC ID to deploy the  cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| eb\_all\_settings | n/a |
| eb\_aws\_security\_group\_id | n/a |
| eb\_environment\_id | n/a |
| eb\_load\_balancers | n/a |
| iam\_role\_eb\_arn | ARN for EB IAM role |
| iam\_role\_eb\_name | Name of EB IAM role |
| ssm\_association\_join\_domain\_automation | n/a |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-eb-windows/blob/master/LICENSE) for full details.