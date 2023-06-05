variable "name" {
  description = "Name for this application"
}

variable "description" {
  type        = string
  default     = ""
  description = "Short description of the Environment"
}

variable "environment" {
  default     = "dev"
  description = "Name of this environment"
}

variable "eb_platform" {
  default     = "dotnet"
  description = "Platform type, e.g. 'dotnet', 'dotnetcorelinux'"
}

variable "eb_solution_stack_name" {
  description = "Stack name passed to ElasticBeanstalk"
}

variable "eb_application_name" {
  default     = ""
  description = "EB application name (empty value will create an application)"
}

variable "environment_type" {
  type        = string
  default     = "LoadBalanced"
  description = "Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `loadbalancer_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments)"
}

variable "loadbalancer_type" {
  type        = string
  default     = "application"
  description = "Load Balancer type, e.g. 'application' or 'network'"
}

variable "loadbalancer_is_shared" {
  type        = bool
  default     = false
  description = "Flag to create a shared application loadbalancer. Only when loadbalancer_type = \"application\" https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-cfg-alb-shared.html"
}

variable "shared_loadbalancer_arn" {
  type        = string
  default     = ""
  description = "ARN of the shared application load balancer. Only when loadbalancer_type = \"application\"."
}

variable "loadbalancer_subnets" {
  type        = list(string)
  description = "List of subnets to place Elastic Load Balancer"
  default     = []
}

variable "application_subnets" {
  type        = list(string)
  description = "List of subnets to place EC2 instances"
}

variable "availability_zone_selector" {
  type        = string
  default     = "Any 2"
  description = "Availability Zone selector"
}

variable "enable_spot_instances" {
  type        = bool
  default     = false
  description = "Enable Spot Instance requests for your environment"
}

variable "spot_fleet_on_demand_base" {
  type        = number
  default     = 0
  description = "The minimum number of On-Demand Instances that your Auto Scaling group provisions before considering Spot Instances as your environment scales up. This option is relevant only when enable_spot_instances is true."
}

variable "spot_fleet_on_demand_above_base_percentage" {
  type        = number
  default     = -1
  description = "The percentage of On-Demand Instances as part of additional capacity that your Auto Scaling group provisions beyond the SpotOnDemandBase instances. This option is relevant only when enable_spot_instances is true."
}

variable "spot_max_price" {
  type        = number
  default     = -1
  description = "The maximum price per unit hour, in US$, that you're willing to pay for a Spot Instance. This option is relevant only when enable_spot_instances is true. Valid values are between 0.001 and 20.0"
}

variable "eb_wait_for_ready_timeout" {
  type        = string
  default     = "20m"
  description = "The maximum duration to wait for the Elastic Beanstalk Environment to be in a ready state before timing out"
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Whether to associate public IP addresses to the instances"
}

variable "eb_tier" {
  type        = string
  default     = "WebServer"
  description = "Elastic Beanstalk Environment tier, 'WebServer' or 'Worker'"
}

variable "eb_version_label" {
  type        = string
  default     = "latest"
  description = "Elastic Beanstalk Application version to deploy"
}

variable "rolling_update_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable rolling update"
}

variable "rolling_update_type" {
  type        = string
  default     = "Health"
  description = "`Health` or `Immutable`. Set it to `Immutable` to apply the configuration change to a fresh group of instances"
}

variable "deployment_policy" {
  type        = string
  default     = "Rolling"
  description = "Use the DeploymentPolicy option to set the deployment type. The following values are supported: `AllAtOnce`, `Rolling`, `RollingWithAdditionalBatch`, `Immutable`, `TrafficSplitting`"
}

variable "updating_min_in_service" {
  type        = number
  default     = 1
  description = "Minimum number of instances in service during update"
}

variable "updating_max_batch" {
  type        = number
  default     = 1
  description = "Maximum number of instances to update at once"
}

variable "health_streaming_enabled" {
  type        = bool
  default     = false
  description = "For environments with enhanced health reporting enabled, whether to create a group in CloudWatch Logs for environment health and archive Elastic Beanstalk environment health data. For information about enabling enhanced health, see aws:elasticbeanstalk:healthreporting:system."
}

variable "health_streaming_delete_on_terminate" {
  type        = bool
  default     = false
  description = "Whether to delete the log group when the environment is terminated. If false, the health data is kept RetentionInDays days."
}

variable "health_streaming_retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to keep the archived health data before it expires."
}

variable "healthcheck_url" {
  type        = string
  default     = "/"
  description = "Application Health Check URL. Elastic Beanstalk will call this URL to check the health of the application running on EC2 instances"
}

variable "enable_log_publication_control" {
  type        = bool
  default     = false
  description = "Copy the log files for your application's Amazon EC2 instances to the Amazon S3 bucket associated with your application"
}

variable "enable_stream_logs" {
  type        = bool
  default     = false
  description = "Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in your environment"
}

variable "logs_delete_on_terminate" {
  type        = bool
  default     = false
  description = "Whether to delete the log groups when the environment is terminated. If false, the logs are kept RetentionInDays days"
}

variable "logs_retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to keep log events before they expire."
}

variable "loadbalancer_access_logs_s3_enabled" {
  type        = bool
  default     = false
  description = "Enable or disable logs on load balancer"
}

variable "loadbalancer_certificate_arn" {
  type        = string
  default     = ""
  description = "Load Balancer SSL certificate ARN. The certificate must be present in AWS Certificate Manager"
}

variable "loadbalancer_ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  description = "Specify a security policy to apply to the listener. This option is only applicable to environments with an application load balancer"
}

variable "loadbalancer_security_groups" {
  type        = list(string)
  default     = []
  description = "Load balancer security groups"
}

variable "loadbalancer_idle_timeout" {
  type        = number
  default     = 60
  description = "Load balancer connection idle timeout"
}

variable "loadbalancer_managed_security_group" {
  type        = string
  default     = ""
  description = "Load balancer managed security group"
}

variable "http_listener_enabled" {
  type        = bool
  default     = true
  description = "Enable port 80 (http)"
}

variable "application_port" {
  type        = number
  default     = 80
  description = "Port application is listening on"
}

variable "preferred_start_time" {
  type        = string
  default     = "Sun:10:00"
  description = "Configure a maintenance window for managed actions in UTC"
}

variable "update_level" {
  type        = string
  default     = "minor"
  description = "The highest level of update to apply with managed platform updates"
}

variable "instance_refresh_enabled" {
  type        = bool
  default     = false
  description = "Enable weekly instance replacement."
}

variable "root_volume_size" {
  type        = number
  default     = 30
  description = "The size of the EBS root volume"
}

variable "root_volume_type" {
  type        = string
  default     = "gp2"
  description = "The type of the EBS root volume"
}

variable "elb_scheme" {
  type        = string
  default     = "public"
  description = "Specify `internal` if you want to create an internal load balancer in your Amazon VPC so that your Elastic Beanstalk application cannot be accessed from outside your Amazon VPC"
}

variable "additional_settings" {
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))

  default     = []
  description = "Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html"
}

variable "deployment_batch_size_type" {
  type        = string
  default     = "Percentage"
  description = "The type of number that is specified in deployment_batch_size_type"
}

variable "deployment_batch_size" {
  type        = number
  default     = 100
  description = "Percentage or fixed number of Amazon EC2 instances in the Auto Scaling group on which to simultaneously perform deployments. Valid values vary per deployment_batch_size_type setting"
}

variable "deployment_ignore_health_check" {
  type        = bool
  default     = false
  description = "Do not cancel a deployment due to failed health checks"
}

variable "deployment_timeout" {
  type        = number
  default     = 600
  description = "Number of seconds to wait for an instance to complete executing commands"
}

variable "healthcheck_interval" {
  type        = number
  default     = 10
  description = "The interval of time, in seconds, that Elastic Load Balancing checks the health of the Amazon EC2 instances of your application"
}

variable "healthcheck_timeout" {
  type        = number
  default     = 5
  description = "The amount of time, in seconds, to wait for a response during a health check. Note that this option is only applicable to environments with an application load balancer"
}

variable "healthcheck_healthy_threshold_count" {
  type        = number
  default     = 3
  description = "The number of consecutive successful requests before Elastic Load Balancing changes the instance health status"
}

variable "healthcheck_unhealthy_threshold_count" {
  type        = number
  default     = 3
  description = "The number of consecutive unsuccessful requests before Elastic Load Balancing changes the instance health status"
}

variable "healthcheck_httpcodes_to_match" {
  type        = list(string)
  default     = ["200", "301"]
  description = "List of HTTP codes that indicate that an instance is healthy. Note that this option is only applicable to environments with a network or application load balancer"
}


variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type"
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

variable "hostnames" {
  type        = list(string)
  default     = []
  description = "Hostname to create on route53 pointing to the EB CNAME (leave empty to prevent creation)"
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
variable "coudwatch_environment_metrics" {
  type        = map(number)
  default     = {}
  description = "Environment metrics to be collected from beanstalk to cloudwatch"
}
variable "coudwatch_instance_metrics" {
  type        = map(number)
  default     = {}
  description = "Instance metrics to be collected from beanstalk to cloudwatch"
}


#### SECURITY GROUP VARIABLES ####
variable "create_security_group" {
  type        = bool
  default     = true
  description = "Set `true` to create and configure a Security Group for the cluster."
}

variable "security_group_name" {
  type        = string
  description = <<-EOT
    The name to assign to the created security group. Must be unique within the VPC.
    If not provided, will be derived from the `null-label.context` passed in.
    EOT
}

variable "security_group_description" {
  type        = string
  default     = "Security Group for ElasticBean Stalk"
  description = <<-EOT
    The description to assign to the created Security Group.
    Warning: Changing the description causes the security group to be replaced.
    EOT
}

variable "associated_security_group_ids" {
  type        = list(string)
  default     = []
  description = <<-EOT
    A list of IDs of Security Groups to associate the created resource with, in addition to the created security group.
    These security groups will not be modified and, if `create_security_group` is `false`, must have rules providing the desired access.
    EOT
}

variable "ingress_rules" {
  type = list(object({
    from_port       = string
    to_port         = string
    protocol        = string
    description     = string
    cidr_blocks     = list(string)
    security_groups = list(string)
    self            = string
  }))
  default     = []
  description = "How long to wait for the security group to be created."
}

variable "egress_rules" {
  type = list(object({
    from_port       = string
    to_port         = string
    protocol        = string
    description     = string
    cidr_blocks     = list(string)
    security_groups = list(string)
    self            = string
  }))
  default     = []
  description = "How long to wait for the security group to be created."
}

variable "s3_bucket_elb_logs_create" {
  type        = bool
  default     = false
  description = "Create or not a bucket to store the elb logs."
}

variable "s3_bucket_elb_logs_name" {
  type        = string
  default     = ""
  description = "Give a name for the S3 Bucket if empyt one will be generate based on the environment and the name."
}

variable "s3_bucket_elb_logs_force_destroy" {
  type        = bool
  default     = false
  description = "Force destroy the S3 bucket for load balancer logs"
}

variable "s3_bucket_elb_logs_encryption_enabled" {
  type        = bool
  default     = true
  description = "When set to 'true' the resource will have aes256 encryption enabled by default"
}

variable "s3_bucket_elb_logs_access_log_bucket_name" {
  type        = string
  default     = ""
  description = "Name of the S3 bucket where s3 access log will be sent to"
}

variable "s3_bucket_elb_logs_versioning_enabled" {
  type        = bool
  default     = true
  description = "When set to 'true' the s3 origin bucket will have versioning enabled"
}

variable "iam_role_policy_attachment_to_instance" {
  type = list(object({
    name       = string
    policy_arn = string
  }))
  default     = []
  description = "List of policies ARN to be attach in the Elastic Beanstalk role instance."
}

variable "solutions_stack_name_regex" {
  type        = string
  default     = ""
  description = "Regex string to apply to the solution stack list returned by AWS"
}
