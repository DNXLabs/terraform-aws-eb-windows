variable "name" {
  description = "Name for this application"
}

variable "environment" {
  default     = "dev"
  description = "Name of this environment"
}

variable "eb_solution_stack_name" {
  description = "Stack name passed to ElasticBeanstalk"
}

variable "eb_application_name" {
  default     = ""
  description = "EB application name (empty value will create an application)"
}

variable "instance_type_1" {
  description = "Instance type for ECS workers (first priority)"
}

variable "instance_type_2" {
  description = "Instance type for ECS workers (second priority)"
}

variable "instance_type_3" {
  description = "Instance type for ECS workers (third priority)"
}

variable "on_demand_percentage" {
  description = "Percentage of on-demand intances vs spot"
  default     = 100
}

variable "on_demand_base_capacity" {
  description = "You can designate a base portion of your total capacity as On-Demand. As the group scales, per your settings, the base portion is provisioned first, while additional On-Demand capacity is percentage-based."
  default     = 0
}

variable "vpc_id" {
  description = "VPC ID to deploy the  cluster"
}

variable "private_subnet_ids" {
  type        = list
  description = "List of private subnet IDs for instances"
}

variable "public_subnet_ids" {
  type        = list
  description = "List of public subnet IDs for ALB"
}

variable "secure_subnet_ids" {
  type        = list
  description = "List of secure subnet IDs for EFS"
}

variable "certificate_arn" {}

variable "asg_min" {
  default     = 1
  description = "Min number of instances for autoscaling group"
}

variable "asg_max" {
  default     = 4
  description = "Max number of instances for autoscaling group"
}

variable "hosted_zone" {
  default     = ""
  description = "Hosted zone to create the hostname"
}

variable "hostname" {
  default     = ""
  description = "Hostname to create on route53 pointing to the EB CNAME (leave empty to prevent creation)"
}

variable "security_group_ids" {
  type        = list
  default     = []
  description = "Extra security groups for instances"
}

variable "autoscaling_health_check_grace_period" {
  default     = 300
  description = "The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service"
}

variable "autoscaling_default_cooldown" {
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
}

variable "key_name" {
  default     = ""
  description = "Defines a SSH keypair to access EB instances (leave empty to create one)"
}

variable "cloudwatch_logs_retention" {
  default     = 120
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
}

variable "alarm_sns_topics" {
  default     = []
  description = "Alarm topics to create and alert on ECS service metrics. Leaving empty disables all alarms."
}

variable "alarm_asg_high_cpu_threshold" {
  description = "Max threshold average CPU percentage allowed in a 2 minutes interval (use 0 to disable this alarm)"
  default     = 80
}

variable "alarm_alb_latency_anomaly_threshold" {
  description = "ALB Latency anomaly detection width (use 0 to disable this alarm)"
  default     = 4
}

variable "alarm_alb_500_errors_threshold" {
  description = "Max threshold of HTTP 500 errors allowed in a 5 minutes interval (use 0 to disable this alarm)"
  default     = 10
}

variable "alarm_alb_400_errors_threshold" {
  description = "Max threshold of HTTP 4000 errors allowed in a 5 minutes interval (use 0 to disable this alarm)"
  default     = 10
}

variable "enable_schedule" {
  default     = false
  description = "Enables schedule to shut down and start up instances outside business hours"
}

variable "schedule_cron_start" {
  type        = string
  default     = ""
  description = "Cron expression to define when to trigger a start of the auto-scaling group. E.g. '0 20 * * *' to start at 8pm GMT time"
}

variable "schedule_cron_stop" {
  type        = string
  default     = ""
  description = "Cron expression to define when to trigger a stop of the auto-scaling group. E.g. '0 10 * * *' to stop at 10am GMT time"
}

# alarm_asg_high_cpu_threshold

variable "ad_directory_id" {
  default     = ""
  description = "ID of directory from AWS Simple AD"
}

variable "ad_directory_name" {
  default     = ""
  description = "Active Directory Name (leave it blank to disable join domain automation)"
}

variable "ad_directory_ip1" {
  default     = ""
  description = "AD Directory first IP address"
}

variable "ad_directory_ip2" {
  default     = ""
  description = "AD second IP address"
}

variable "stickiness_enabled" {
  default     = false
  description = "Route requests from the same client to the same target"
}

variable "stickiness_expiration" {
  default     = 86400
  description = "Cookie expiration period, in seconds"
}

variable "ignore_iam_account_alias" {
  default     = false
  description = "Disables data source for iam_account_alias used on cloudwatch alarms"
}