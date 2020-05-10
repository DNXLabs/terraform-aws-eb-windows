resource "aws_elastic_beanstalk_application" "app" {
  count       = var.eb_application_name == "" ? 1 : 0
  name        = var.name
  description = "${var.name} EB APP"
}

locals {
  eb_settings = [
    # {
    #   name      = "AccessLogsS3Bucket"
    #   namespace = "aws:elbv2:loadbalancer"
    #   value     = ""
    # },
    {
      name      = "AccessLogsS3Enabled"
      namespace = "aws:elbv2:loadbalancer"
      value     = "false"
    },
    # {
    #   name      = "AccessLogsS3Prefix"
    #   namespace = "aws:elbv2:loadbalancer"
    #   value     = ""
    # },
    {
      name      = "AppSource"
      namespace = "aws:cloudformation:template:parameter"
      value     = "https://elasticbeanstalk-samples-ap-southeast-2.s3-ap-southeast-2.amazonaws.com/FirstSample-v3.zip"
    },
    # {
    #   name      = "Application Healthcheck URL"
    #   namespace = "aws:elasticbeanstalk:application"
    #   value     = ""
    # },
    {
      name      = "AssociatePublicIpAddress"
      namespace = "aws:ec2:vpc"
      value     = "false"
    },
    {
      name      = "Automatically Terminate Unhealthy Instances"
      namespace = "aws:elasticbeanstalk:monitoring"
      value     = "true"
    },
    {
      name      = "Availability Zones"
      namespace = "aws:autoscaling:asg"
      value     = "Any"
    },
    {
      name      = "BatchSize"
      namespace = "aws:elasticbeanstalk:command"
      value     = "100"
    },
    {
      name      = "BatchSizeType"
      namespace = "aws:elasticbeanstalk:command"
      value     = "Percentage"
    },
    # {
    #   name      = "BlockDeviceMappings"
    #   namespace = "aws:autoscaling:launchconfiguration"
    #   value     = ""
    # },
    {
      name      = "BreachDuration"
      namespace = "aws:autoscaling:trigger"
      value     = "5"
    },
    # {
    #   name      = "ConfigDocument"
    #   namespace = "aws:elasticbeanstalk:healthreporting:system"
    #   value = jsonencode(
    #     {
    #       CloudWatchMetrics = {
    #         Environment = {
    #           ApplicationLatencyP10     = null
    #           ApplicationLatencyP50     = null
    #           ApplicationLatencyP75     = null
    #           ApplicationLatencyP85     = null
    #           ApplicationLatencyP90     = null
    #           ApplicationLatencyP95     = null
    #           ApplicationLatencyP99     = null
    #           "ApplicationLatencyP99.9" = null
    #           ApplicationRequests2xx    = null
    #           ApplicationRequests3xx    = null
    #           ApplicationRequests4xx    = null
    #           ApplicationRequests5xx    = null
    #           ApplicationRequestsTotal  = null
    #           InstancesDegraded         = null
    #           InstancesInfo             = null
    #           InstancesNoData           = null
    #           InstancesOk               = null
    #           InstancesPending          = null
    #           InstancesSevere           = null
    #           InstancesUnknown          = null
    #           InstancesWarning          = null
    #         }
    #         Instance = {
    #           ApplicationLatencyP10     = null
    #           ApplicationLatencyP50     = null
    #           ApplicationLatencyP75     = null
    #           ApplicationLatencyP85     = null
    #           ApplicationLatencyP90     = null
    #           ApplicationLatencyP95     = null
    #           ApplicationLatencyP99     = null
    #           "ApplicationLatencyP99.9" = null
    #           ApplicationRequests2xx    = null
    #           ApplicationRequests3xx    = null
    #           ApplicationRequests4xx    = null
    #           ApplicationRequests5xx    = null
    #           ApplicationRequestsTotal  = null
    #           CPUIdle                   = null
    #           CPUPrivileged             = null
    #           CPUUser                   = null
    #           InstanceHealth            = null
    #         }
    #       }
    #       Rules = {
    #         Environment = {
    #           Application = {
    #             ApplicationRequests4xx = {
    #               Enabled = true
    #             }
    #           }
    #           ELB = {
    #             ELBRequests4xx = {
    #               Enabled = true
    #             }
    #           }
    #         }
    #       }
    #       Version = 1
    #     }
    #   )
    # },
    {
      name      = "Cooldown"
      namespace = "aws:autoscaling:asg"
      value     = "360"
    },
    # {
    #   name      = "Custom Availability Zones"
    #   namespace = "aws:autoscaling:asg"
    #   value     = ""
    # },
    {
      name      = "DefaultProcess"
      namespace = "aws:elbv2:listener:default"
      value     = "default"
    },
    {
      name      = "DefaultSSHPort"
      namespace = "aws:elasticbeanstalk:control"
      value     = "22"
    },
    {
      name      = "DeleteOnTerminate"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      value     = "false"
    },
    {
      name      = "DeleteOnTerminate"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
      value     = "false"
    },
    {
      name      = "DeploymentPolicy"
      namespace = "aws:elasticbeanstalk:command"
      value     = "AllAtOnce"
    },
    {
      name      = "DeregistrationDelay"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "20"
    },
    {
      name      = "EC2KeyName"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = "${var.key_name}"
    },
    {
      name      = "ELBScheme"
      namespace = "aws:ec2:vpc"
      value     = "public"
    },
    {
      name      = "ELBSubnets"
      namespace = "aws:ec2:vpc"
      value     = join(",", var.public_subnet_ids)
    },
    {
      name      = "Enable 32-bit Applications"
      namespace = "aws:elasticbeanstalk:container:dotnet:apppool"
      value     = "False"
    },
    {
      name      = "EnableSpot"
      namespace = "aws:ec2:instances"
      value     = "true"
    },
    {
      name      = "EnvironmentType"
      namespace = "aws:elasticbeanstalk:environment"
      value     = "LoadBalanced"
    },
    {
      name      = "EnvironmentVariables"
      namespace = "aws:cloudformation:template:parameter"
      value     = join(",", var.env_vars)
    },
    {
      name      = "EvaluationPeriods"
      namespace = "aws:autoscaling:trigger"
      value     = "1"
    },
    # {
    #   name      = "ExternalExtensionsS3Bucket"
    #   namespace = "aws:elasticbeanstalk:environment"
    #   value     = ""
    # },
    # {
    #   name      = "ExternalExtensionsS3Key"
    #   namespace = "aws:elasticbeanstalk:environment"
    #   value     = ""
    # },
    {
      name      = "HealthCheckInterval"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "15"
    },
    {
      name      = "HealthCheckPath"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "/"
    },
    {
      name      = "HealthCheckSuccessThreshold"
      namespace = "aws:elasticbeanstalk:healthreporting:system"
      value     = "Ok"
    },
    {
      name      = "HealthCheckTimeout"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "5"
    },
    {
      name      = "HealthStreamingEnabled"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
      value     = "false"
    },
    {
      name      = "HealthyThresholdCount"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "3"
    },
    {
      name      = "IamInstanceProfile"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = aws_iam_instance_profile.eb.name
    },
    # {
    #   name      = "IdleTimeout"
    #   namespace = "aws:elbv2:loadbalancer"
    #   value     = ""
    # },
    {
      name      = "IgnoreHealthCheck"
      namespace = "aws:elasticbeanstalk:command"
      value     = "false"
    },
    # {
    #   name      = "ImageId"
    #   namespace = "aws:autoscaling:launchconfiguration"
    #   value     = "ami-0b353b1e6a5dabc74"
    # },
    {
      name      = "InstancePort"
      namespace = "aws:cloudformation:template:parameter"
      value     = "80"
    },
    {
      name      = "InstanceRefreshEnabled"
      namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
      value     = "false"
    },
    {
      name      = "InstanceType"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = var.instance_type_1
    },
    {
      name      = "InstanceTypeFamily"
      namespace = "aws:cloudformation:template:parameter"
      value     = element(split(".", var.instance_type_1), 0)
    },
    {
      name      = "InstanceTypes"
      namespace = "aws:ec2:instances"
      value     = "${var.instance_type_1}, ${var.instance_type_2}, ${var.instance_type_3}"
    },
    {
      name      = "LargerInstanceTypeRequired"
      namespace = "aws:cloudformation:template:parameter"
      value     = "true"
    },
    {
      name      = "LaunchTimeout"
      namespace = "aws:elasticbeanstalk:control"
      value     = "0"
    },
    {
      name      = "LaunchType"
      namespace = "aws:elasticbeanstalk:control"
      value     = "Migration"
    },
    {
      name      = "ListenerEnabled"
      namespace = "aws:elbv2:listener:default"
      value     = "true"
    },
    {
      name      = "LoadBalancerType"
      namespace = "aws:elasticbeanstalk:environment"
      value     = "application"
    },
    {
      name      = "LogPublicationControl"
      namespace = "aws:elasticbeanstalk:hostmanager"
      value     = "false"
    },
    {
      name      = "LowerBreachScaleIncrement"
      namespace = "aws:autoscaling:trigger"
      value     = "-1"
    },
    {
      name      = "LowerThreshold"
      namespace = "aws:autoscaling:trigger"
      value     = "35"
    },
    {
      name      = "ManagedActionsEnabled"
      namespace = "aws:elasticbeanstalk:managedactions"
      value     = "true"
    },
    # {
    #   name      = "MatcherHTTPCode"
    #   namespace = "aws:elasticbeanstalk:environment:process:default"
    #   value     = ""
    # },
    {
      name      = "MaxBatchSize"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = "1"
    },
    {
      name      = "MaxSize"
      namespace = "aws:autoscaling:asg"
      value     = var.asg_max
    },
    {
      name      = "MeasureName"
      namespace = "aws:autoscaling:trigger"
      value     = "CPUUtilization"
    },
    {
      name      = "MinInstancesInService"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = "1"
    },
    {
      name      = "MinSize"
      namespace = "aws:autoscaling:asg"
      value     = var.asg_min
    },
    {
      name      = "MonitoringInterval"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = "5 minute"
    },
    # {
    #   name      = "Notification Endpoint"
    #   namespace = "aws:elasticbeanstalk:sns:topics"
    #   value     = ""
    # },
    {
      name      = "Notification Protocol"
      namespace = "aws:elasticbeanstalk:sns:topics"
      value     = "email"
    },
    # {
    #   name      = "Notification Topic ARN"
    #   namespace = "aws:elasticbeanstalk:sns:topics"
    #   value     = ""
    # },
    # {
    #   name      = "Notification Topic Name"
    #   namespace = "aws:elasticbeanstalk:sns:topics"
    #   value     = ""
    # },
    # {
    #   name      = "PauseTime"
    #   namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    #   value     = ""
    # },
    {
      name      = "Period"
      namespace = "aws:autoscaling:trigger"
      value     = "5"
    },
    {
      name      = "Port"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "80"
    },
    {
      name      = "PreferredStartTime"
      namespace = "aws:elasticbeanstalk:managedactions"
      value     = "Wed:15:00"
    },
    {
      name      = "Protocol"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "HTTP"
    },
    {
      name      = "Protocol"
      namespace = "aws:elbv2:listener:default"
      value     = "HTTP"
    },
    {
      name      = "RetentionInDays"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      value     = var.cloudwatch_logs_retention
    },
    {
      name      = "RetentionInDays"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
      value     = var.cloudwatch_logs_retention
    },
    {
      name      = "RollbackLaunchOnFailure"
      namespace = "aws:elasticbeanstalk:control"
      value     = "false"
    },
    {
      name      = "RollingUpdateEnabled"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = "true"
    },
    {
      name      = "RollingUpdateType"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = "Health"
    },
    # {
    #   name      = "RootVolumeIOPS"
    #   namespace = "aws:autoscaling:launchconfiguration"
    #   value     = ""
    # },
    # {
    #   name      = "RootVolumeSize"
    #   namespace = "aws:autoscaling:launchconfiguration"
    #   value     = ""
    # },
    {
      name      = "RootVolumeType"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = "gp2"
    },
    # {
    #   name      = "Rules"
    #   namespace = "aws:elbv2:listener:default"
    #   value     = ""
    # },
    {
      name      = "SSHSourceRestriction"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = "tcp,22,22,0.0.0.0/0"
    },
    # {
    #   name      = "SSLCertificateArns"
    #   namespace = "aws:elbv2:listener:default"
    #   value     = ""
    # },
    # {
    #   name      = "SSLPolicy"
    #   namespace = "aws:elbv2:listener:default"
    #   value     = ""
    # },
    # {
    #   name      = "SecurityGroups"
    #   namespace = "aws:autoscaling:launchconfiguration"
    #   value     = ""
    # },
    # {
    #   name      = "SecurityGroups"
    #   namespace = "aws:elbv2:loadbalancer"
    #   value     = ""
    # },
    {
      name      = "ServiceRole"
      namespace = "aws:elasticbeanstalk:environment"
      value     = aws_iam_role.eb_service.arn
    },
    {
      name      = "SpotFleetOnDemandAboveBasePercentage"
      namespace = "aws:ec2:instances"
      value     = var.on_demand_percentage
    },
    {
      name      = "SpotFleetOnDemandBase"
      namespace = "aws:ec2:instances"
      value     = var.on_demand_base_capacity
    },
    # {
    #   name      = "SpotMaxPrice"
    #   namespace = "aws:ec2:instances"
    #   value     = ""
    # },
    {
      name      = "Statistic"
      namespace = "aws:autoscaling:trigger"
      value     = "Average"
    },
    {
      name      = "StickinessEnabled"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "false"
    },
    {
      name      = "StickinessLBCookieDuration"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "86400"
    },
    {
      name      = "StickinessType"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "lb_cookie"
    },
    {
      name      = "StreamLogs"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      value     = "true"
    },
    {
      name      = "Subnets"
      namespace = "aws:ec2:vpc"
      value     = join(",", var.private_subnet_ids)
    },
    {
      name      = "SystemType"
      namespace = "aws:cloudformation:template:parameter"
      value     = "enhanced"
    },
    {
      name      = "SystemType"
      namespace = "aws:elasticbeanstalk:healthreporting:system"
      value     = "enhanced"
    },
    {
      name      = "Target Runtime"
      namespace = "aws:elasticbeanstalk:container:dotnet:apppool"
      value     = "4.0"
    },
    {
      name      = "Timeout"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = "PT30M"
    },
    {
      name      = "Timeout"
      namespace = "aws:elasticbeanstalk:command"
      value     = "600"
    },
    {
      name      = "UnhealthyThresholdCount"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "5"
    },
    {
      name      = "Unit"
      namespace = "aws:autoscaling:trigger"
      value     = "Percent"
    },
    {
      name      = "UpdateLevel"
      namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
      value     = "minor"
    },
    {
      name      = "UpperBreachScaleIncrement"
      namespace = "aws:autoscaling:trigger"
      value     = "1"
    },
    {
      name      = "UpperThreshold"
      namespace = "aws:autoscaling:trigger"
      value     = "65"
    },
    {
      name      = "VPCId"
      namespace = "aws:ec2:vpc"
      value     = var.vpc_id
    },
    {
      name      = "XRayEnabled"
      namespace = "aws:elasticbeanstalk:xray"
      value     = "true"
    },
  ]
}

resource "aws_elastic_beanstalk_environment" "env" {
  name                = "${var.name}-${var.environment}"
  cname_prefix        = "${var.name}-${var.environment}"
  application         = var.eb_application_name == "" ? aws_elastic_beanstalk_application.app[0].name : var.eb_application_name
  solution_stack_name = var.eb_solution_stack_name

  dynamic "setting" {
    for_each = local.eb_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
      resource  = ""
    }
  }
}

