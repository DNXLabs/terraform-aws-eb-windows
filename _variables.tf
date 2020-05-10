variable "name" {
  description = "Name for this application"
}

variable "environment" {
  default     = "dev"
  description = "Name of this environment"
}

variable "eb_solution_stack_name" {
  default     = "64bit Windows Server 2019 v2.5.2 running IIS 10.0"
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
  description = "Defines a SSH keypair to access EB instances"
}

variable "cloudwatch_logs_retention" {
  default     = 120
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
}

variable "env_vars" {
  default     = []
  description = ""
}
