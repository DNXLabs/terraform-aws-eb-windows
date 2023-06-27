locals {
  eb_default_settings = [
    {
      name      = "EnvironmentType"
      namespace = "aws:elasticbeanstalk:environment"
      value     = var.environment_type
    },
    {
      name      = "ServiceRole"
      namespace = "aws:elasticbeanstalk:environment"
      value     = aws_iam_role.eb_service.arn
    },
    {
      name      = "DeregistrationDelay"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "20"
    },
    {
      name      = "RollbackLaunchOnFailure"
      namespace = "aws:elasticbeanstalk:control"
      value     = "false"
    },
    {
      name      = "DefaultSSHPort"
      namespace = "aws:elasticbeanstalk:control"
      value     = "22"
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
      name      = "Automatically Terminate Unhealthy Instances"
      namespace = "aws:elasticbeanstalk:monitoring"
      value     = "true"
    },
    {
      name      = "BatchSize"
      namespace = "aws:elasticbeanstalk:command"
      value     = var.deployment_batch_size
    },
    {
      name      = "BatchSizeType"
      namespace = "aws:elasticbeanstalk:command"
      value     = var.deployment_batch_size_type
    },
    {
      name      = "DeploymentPolicy"
      namespace = "aws:elasticbeanstalk:command"
      value     = "AllAtOnce"
    },
    {
      name      = "IgnoreHealthCheck"
      namespace = "aws:elasticbeanstalk:command"
      value     = var.deployment_ignore_health_check
    },
    {
      name      = "Timeout"
      namespace = "aws:elasticbeanstalk:command"
      value     = var.deployment_timeout
    },
    {
      name      = "InstancePort"
      namespace = "aws:cloudformation:template:parameter"
      value     = "80"
    },
    {
      name      = "ConfigDocument"
      namespace = "aws:elasticbeanstalk:healthreporting:system"
      value = (var.eb_platform == "dotnet"
        ? jsonencode(
          {
            CloudWatchMetrics = {
              Environment = {
                ApplicationLatencyP10     = try(var.coudwatch_environment_metrics.ApplicationLatencyP10, null)
                ApplicationLatencyP50     = try(var.coudwatch_environment_metrics.ApplicationLatencyP50, null)
                ApplicationLatencyP75     = try(var.coudwatch_environment_metrics.ApplicationLatencyP75, null)
                ApplicationLatencyP85     = try(var.coudwatch_environment_metrics.ApplicationLatencyP85, null)
                ApplicationLatencyP90     = try(var.coudwatch_environment_metrics.ApplicationLatencyP90, null)
                ApplicationLatencyP95     = try(var.coudwatch_environment_metrics.ApplicationLatencyP95, null)
                ApplicationLatencyP99     = try(var.coudwatch_environment_metrics.ApplicationLatencyP99, null)
                "ApplicationLatencyP99.9" = try(var.coudwatch_environment_metrics.ApplicationLatencyP99.9, null)
                ApplicationRequests2xx    = try(var.coudwatch_environment_metrics.ApplicationRequests2xx, null)
                ApplicationRequests3xx    = try(var.coudwatch_environment_metrics.ApplicationRequests3xx, null)
                ApplicationRequests4xx    = try(var.coudwatch_environment_metrics.ApplicationRequests4xx, null)
                ApplicationRequests5xx    = try(var.coudwatch_environment_metrics.ApplicationRequests5xx, null)
                ApplicationRequestsTotal  = try(var.coudwatch_environment_metrics.ApplicationRequestsTotal, null)
                InstancesDegraded         = try(var.coudwatch_environment_metrics.InstancesDegraded, null)
                InstancesInfo             = try(var.coudwatch_environment_metrics.InstancesInfo, null)
                InstancesNoData           = try(var.coudwatch_environment_metrics.InstancesNoData, null)
                InstancesOk               = try(var.coudwatch_environment_metrics.InstancesOk, null)
                InstancesPending          = try(var.coudwatch_environment_metrics.InstancesPending, null)
                InstancesSevere           = try(var.coudwatch_environment_metrics.InstancesSevere, null)
                InstancesUnknown          = try(var.coudwatch_environment_metrics.InstancesUnknown, null)
                InstancesWarning          = try(var.coudwatch_environment_metrics.InstancesWarning, null)
              }
              Instance = {
                ApplicationLatencyP10     = try(var.coudwatch_instance_metrics.ApplicationLatencyP10, null)
                ApplicationLatencyP50     = try(var.coudwatch_instance_metrics.ApplicationLatencyP50, null)
                ApplicationLatencyP75     = try(var.coudwatch_instance_metrics.ApplicationLatencyP75, null)
                ApplicationLatencyP85     = try(var.coudwatch_instance_metrics.ApplicationLatencyP85, null)
                ApplicationLatencyP90     = try(var.coudwatch_instance_metrics.ApplicationLatencyP90, null)
                ApplicationLatencyP95     = try(var.coudwatch_instance_metrics.ApplicationLatencyP95, null)
                ApplicationLatencyP99     = try(var.coudwatch_instance_metrics.ApplicationLatencyP99, null)
                "ApplicationLatencyP99.9" = try(var.coudwatch_instance_metrics.ApplicationLatencyP99.9, null)
                ApplicationRequests2xx    = try(var.coudwatch_instance_metrics.ApplicationRequests2xx, null)
                ApplicationRequests3xx    = try(var.coudwatch_instance_metrics.ApplicationRequests3xx, null)
                ApplicationRequests4xx    = try(var.coudwatch_instance_metrics.ApplicationRequests4xx, null)
                ApplicationRequests5xx    = try(var.coudwatch_instance_metrics.ApplicationRequests5xx, null)
                ApplicationRequestsTotal  = try(var.coudwatch_instance_metrics.ApplicationRequestsTotal, null)
                CPUIdle                   = try(var.coudwatch_instance_metrics.CPUIdle, null)
                CPUPrivileged             = try(var.coudwatch_instance_metrics.CPUPrivileged, null)
                CPUUser                   = try(var.coudwatch_instance_metrics.CPUUser, null)
                InstanceHealth            = try(var.coudwatch_instance_metrics.InstanceHealth, null)
              }
            }
            Rules = {
              Environment = {
                Application = {
                  ApplicationRequests4xx = {
                    Enabled = true
                  }
                }
                ELB = {
                  ELBRequests4xx = {
                    Enabled = true
                  }
                }
              }
            }
            Version = 1
          }
        )
        : jsonencode(
          {
            CloudWatchMetrics = {
              Environment = {
                ApplicationLatencyP10     = try(var.coudwatch_environment_metrics.ApplicationLatencyP10, null)
                ApplicationLatencyP50     = try(var.coudwatch_environment_metrics.ApplicationLatencyP50, null)
                ApplicationLatencyP75     = try(var.coudwatch_environment_metrics.ApplicationLatencyP75, null)
                ApplicationLatencyP85     = try(var.coudwatch_environment_metrics.ApplicationLatencyP85, null)
                ApplicationLatencyP90     = try(var.coudwatch_environment_metrics.ApplicationLatencyP90, null)
                ApplicationLatencyP95     = try(var.coudwatch_environment_metrics.ApplicationLatencyP95, null)
                ApplicationLatencyP99     = try(var.coudwatch_environment_metrics.ApplicationLatencyP99, null)
                "ApplicationLatencyP99.9" = try(var.coudwatch_environment_metrics.ApplicationLatencyP99.9, null)
                ApplicationRequests2xx    = try(var.coudwatch_environment_metrics.ApplicationRequests2xx, null)
                ApplicationRequests3xx    = try(var.coudwatch_environment_metrics.ApplicationRequests3xx, null)
                ApplicationRequests4xx    = try(var.coudwatch_environment_metrics.ApplicationRequests4xx, null)
                ApplicationRequests5xx    = try(var.coudwatch_environment_metrics.ApplicationRequests5xx, null)
                ApplicationRequestsTotal  = try(var.coudwatch_environment_metrics.ApplicationRequestsTotal, null)
                InstancesDegraded         = try(var.coudwatch_environment_metrics.InstancesDegraded, null)
                InstancesInfo             = try(var.coudwatch_environment_metrics.InstancesInfo, null)
                InstancesNoData           = try(var.coudwatch_environment_metrics.InstancesNoData, null)
                InstancesOk               = try(var.coudwatch_environment_metrics.InstancesOk, null)
                InstancesPending          = try(var.coudwatch_environment_metrics.InstancesPending, null)
                InstancesSevere           = try(var.coudwatch_environment_metrics.InstancesSevere, null)
                InstancesUnknown          = try(var.coudwatch_environment_metrics.InstancesUnknown, null)
                InstancesWarning          = try(var.coudwatch_environment_metrics.InstancesWarning, null)
              }
              Instance = {
                ApplicationLatencyP10     = try(var.coudwatch_instance_metrics.ApplicationLatencyP10, null)
                ApplicationLatencyP50     = try(var.coudwatch_instance_metrics.ApplicationLatencyP50, null)
                ApplicationLatencyP75     = try(var.coudwatch_instance_metrics.ApplicationLatencyP75, null)
                ApplicationLatencyP85     = try(var.coudwatch_instance_metrics.ApplicationLatencyP85, null)
                ApplicationLatencyP90     = try(var.coudwatch_instance_metrics.ApplicationLatencyP90, null)
                ApplicationLatencyP95     = try(var.coudwatch_instance_metrics.ApplicationLatencyP95, null)
                ApplicationLatencyP99     = try(var.coudwatch_instance_metrics.ApplicationLatencyP99, null)
                "ApplicationLatencyP99.9" = try(var.coudwatch_instance_metrics.ApplicationLatencyP99.9, null)
                ApplicationRequests2xx    = try(var.coudwatch_instance_metrics.ApplicationRequests2xx, null)
                ApplicationRequests3xx    = try(var.coudwatch_instance_metrics.ApplicationRequests3xx, null)
                ApplicationRequests4xx    = try(var.coudwatch_instance_metrics.ApplicationRequests4xx, null)
                ApplicationRequests5xx    = try(var.coudwatch_instance_metrics.ApplicationRequests5xx, null)
                ApplicationRequestsTotal  = try(var.coudwatch_instance_metrics.ApplicationRequestsTotal, null)
                CPUIdle                   = try(var.coudwatch_instance_metrics.CPUIdle, null)
                CPUSystem                 = try(var.coudwatch_instance_metrics.CPUSystem, null)
                CPUUser                   = try(var.coudwatch_instance_metrics.CPUUser, null)
                InstanceHealth            = try(var.coudwatch_instance_metrics.InstanceHealth, null)
              }
            }
            Rules = {
              Environment = {
                Application = {
                  ApplicationRequests4xx = {
                    Enabled = true
                  }
                }
                ELB = {
                  ELBRequests4xx = {
                    Enabled = true
                  }
                }
              }
            }
            Version = 1
          }
      ))
    },
    {
      name      = "HealthCheckSuccessThreshold"
      namespace = "aws:elasticbeanstalk:healthreporting:system"
      value     = "Ok"
    },
    {
      name      = "SystemType"
      namespace = "aws:elasticbeanstalk:healthreporting:system"
      value     = "enhanced"
    },
    {
      name      = "InstanceRefreshEnabled"
      namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
      value     = var.instance_refresh_enabled
    },
    {
      name      = "UpdateLevel"
      namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
      value     = var.update_level
    },
    {
      name      = "ManagedActionsEnabled"
      namespace = "aws:elasticbeanstalk:managedactions"
      value     = "true"
    },
    {
      name      = "PreferredStartTime"
      namespace = "aws:elasticbeanstalk:managedactions"
      value     = var.preferred_start_time
    },
    {
      name      = "XRayEnabled"
      namespace = "aws:elasticbeanstalk:xray"
      value     = "true"
    },
  ]

  eb_dotnet_settings = [
    {
      name      = "LargerInstanceTypeRequired"
      namespace = "aws:cloudformation:template:parameter"
      value     = "true"
    },
    {
      name      = "SystemType"
      namespace = "aws:cloudformation:template:parameter"
      value     = "enhanced"
    },
    {
      name      = "Enable 32-bit Applications"
      namespace = "aws:elasticbeanstalk:container:dotnet:apppool"
      value     = "False"
    },
    {
      name      = "Target Runtime"
      namespace = "aws:elasticbeanstalk:container:dotnet:apppool"
      value     = "4.0"
    },
  ]

  eb_vpc = [
    {
      name      = "VPCId"
      namespace = "aws:ec2:vpc"
      value     = var.vpc_id
    },
    {
      name      = "AssociatePublicIpAddress"
      namespace = "aws:ec2:vpc"
      value     = var.associate_public_ip_address
    },
    {
      name      = "Subnets"
      namespace = "aws:ec2:vpc"
      value     = join(",", var.application_subnets)
    },
  ]

  eb_asg = [
    {
      name      = "Availability Zones"
      namespace = "aws:autoscaling:asg"
      value     = var.availability_zone_selector
    },
    {
      name      = "MinSize"
      namespace = "aws:autoscaling:asg"
      value     = var.asg_min
    },
    {
      name      = "MaxSize"
      namespace = "aws:autoscaling:asg"
      value     = var.asg_max
    },
    {
      name      = "Cooldown"
      namespace = "aws:autoscaling:asg"
      value     = "360"
    },
    {
      name      = "Period"
      namespace = "aws:autoscaling:trigger"
      value     = "5"
    },
    {
      name      = "EvaluationPeriods"
      namespace = "aws:autoscaling:trigger"
      value     = "1"
    },
    {
      name      = "Statistic"
      namespace = "aws:autoscaling:trigger"
      value     = "Average"
    },
    {
      name      = "Unit"
      namespace = "aws:autoscaling:trigger"
      value     = "Percent"
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
      name      = "MeasureName"
      namespace = "aws:autoscaling:trigger"
      value     = "CPUUtilization"
    },
    {
      name      = "BreachDuration"
      namespace = "aws:autoscaling:trigger"
      value     = "5"
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
      name      = "RollingUpdateEnabled"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = var.rolling_update_enabled
    },
    {
      name      = "RollingUpdateType"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = var.rolling_update_type
    },
    {
      name      = "MaxBatchSize"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = var.updating_max_batch
    },
    {
      name      = "MinInstancesInService"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = var.updating_min_in_service
    },
    {
      name      = "Timeout"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      value     = "PT30M"
    },


  ]

  eb_ec2 = [
    {
      name      = "InstanceTypes"
      namespace = "aws:ec2:instances"
      value     = var.instance_type
    },
    {
      name      = "EnableSpot"
      namespace = "aws:ec2:instances"
      value     = var.enable_spot_instances ? "true" : "false"
    },
    {
      name      = "SpotFleetOnDemandAboveBasePercentage"
      namespace = "aws:ec2:instances"
      value     = var.spot_fleet_on_demand_above_base_percentage == -1 ? (var.environment_type == "LoadBalanced" ? 70 : 0) : var.spot_fleet_on_demand_above_base_percentage
    },
    {
      name      = "SpotFleetOnDemandBase"
      namespace = "aws:ec2:instances"
      value     = var.spot_fleet_on_demand_base
    },
    {
      name      = "SpotMaxPrice"
      namespace = "aws:ec2:instances"
      value     = var.spot_max_price == -1 ? "" : var.spot_max_price
    },
  ]

  eb_launch_config = [
    {
      name      = "InstanceType"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = var.instance_type
    },
    {
      name      = "SecurityGroups"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = join(",", compact(sort(concat([try(aws_security_group.eb[0].id, "")], var.associated_security_group_ids))))
    },
    {
      name      = "EC2KeyName"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = "${var.key_name != "" ? var.key_name : aws_key_pair.key[0].key_name}"
    },
    {
      name      = "IamInstanceProfile"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = aws_iam_instance_profile.eb.name
    },
    {
      name      = "RootVolumeType"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = var.root_volume_type #"gp2"
    },
    {
      name      = "RootVolumeSize"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = var.root_volume_size
    },
    {
      name      = "SSHSourceRestriction"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = "tcp,22,22,0.0.0.0/0"
    },
    {
      name      = "MonitoringInterval"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = "5 minute"
    },
    {
      name      = "DisableIMDSv1"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = "true"
    },
  ]

  eb_cloudwatch = [
    {
      name      = "LogPublicationControl"
      namespace = "aws:elasticbeanstalk:hostmanager"
      value     = var.enable_log_publication_control ? "true" : "false"
    },
    {
      name      = "StreamLogs"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      value     = var.enable_stream_logs ? "true" : "false"
    },
    {
      name      = "DeleteOnTerminate"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      value     = var.logs_delete_on_terminate ? "true" : "false"
    },
    {
      name      = "HealthStreamingEnabled"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
      value     = var.health_streaming_enabled ? "true" : "false"
    },
    {
      name      = "DeleteOnTerminate"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
      value     = var.health_streaming_delete_on_terminate ? "true" : "false"
    },
    {
      name      = "RetentionInDays"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      value     = var.cloudwatch_logs_retention
    },
    {
      name      = "RetentionInDays"
      namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
      value     = var.health_streaming_retention_in_days
    }
  ]

  generic_alb_settings = [
    {
      name      = "SecurityGroups"
      namespace = "aws:elbv2:loadbalancer"
      value     = join(",", sort(var.loadbalancer_security_groups))
    },
    {
      name      = "IdleTimeout"
      namespace = "aws:elbv2:loadbalancer"
      value     = var.loadbalancer_idle_timeout
    }
  ]

  shared_alb_settings = [
    {
      name      = "LoadBalancerIsShared"
      namespace = "aws:elasticbeanstalk:environment"
      value     = "true"
    },
    {
      name      = "SharedLoadBalancer"
      namespace = "aws:elbv2:loadbalancer"
      value     = var.shared_loadbalancer_arn
    }
  ]

  alb_default_settings = [
    {
      name      = "AccessLogsS3Enabled"
      namespace = "aws:elbv2:loadbalancer"
      value     = var.loadbalancer_access_logs_s3_enabled
    },
    {
      name      = "ListenerEnabled"
      namespace = "aws:elbv2:listener:default"
      value     = var.http_listener_enabled || var.loadbalancer_certificate_arn == "" ? "true" : "false"
    },
    {
      name      = "ManagedSecurityGroup"
      namespace = "aws:elbv2:loadbalancer"
      value     = var.loadbalancer_managed_security_group
    },
    {
      name      = "ListenerEnabled"
      namespace = "aws:elbv2:listener:443"
      value     = var.loadbalancer_certificate_arn == "" ? "false" : "true"
    },
    {
      name      = "Protocol"
      namespace = "aws:elbv2:listener:443"
      value     = "HTTPS"
    },
    {
      name      = "SSLCertificateArns"
      namespace = "aws:elbv2:listener:443"
      value     = var.loadbalancer_certificate_arn
    },
    {
      name      = "SSLPolicy"
      namespace = "aws:elbv2:listener:443"
      value     = var.loadbalancer_type == "application" ? var.loadbalancer_ssl_policy : ""
    },
    ###===================== Application Load Balancer Health check settings =====================================================###
    # The Application Load Balancer health check does not take into account the Elastic Beanstalk health check path
    # http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-cfg-applicationloadbalancer.html
    # http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-cfg-applicationloadbalancer.html#alb-default-process.config
    {
      name      = "HealthCheckPath"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.healthcheck_url
    },
    {
      name      = "MatcherHTTPCode"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = join(",", sort(var.healthcheck_httpcodes_to_match))
    },
    {
      name      = "HealthCheckTimeout"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.healthcheck_timeout
    },
    {
      name      = "StickinessEnabled"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.stickiness_enabled
    },
    {
      name      = "StickinessLBCookieDuration"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.stickiness_expiration
    },
    {
      name      = "StickinessType"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = "lb_cookie"
    }
  ]

  alb_logs_settings = [
    {
      name      = "AccessLogsS3Bucket"
      namespace = "aws:elbv2:loadbalancer"
      value     = !var.loadbalancer_is_shared ? (var.s3_bucket_elb_logs_name != "" ? var.s3_bucket_elb_logs_name : join("", sort(aws_s3_bucket.elb_logs.*.id))) : ""
    }
  ]

  nlb_settings = [
    {
      name      = "ListenerEnabled"
      namespace = "aws:elbv2:listener:default"
      value     = var.http_listener_enabled
    }
  ]

  generic_elb_settings = [
    {
      name      = "LoadBalancerType"
      namespace = "aws:elasticbeanstalk:environment"
      value     = var.loadbalancer_type
    }
  ]

  beanstalk_elb_settings = [
    {
      name      = "ELBSubnets"
      namespace = "aws:ec2:vpc"
      value     = join(",", sort(var.loadbalancer_subnets))
    },
    {
      name      = "Port"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.application_port
    },
    {
      name      = "Protocol"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.loadbalancer_type == "network" ? "TCP" : var.application_port == 443 ? "HTTPS" : "HTTP"
    },
    {
      name      = "ELBScheme"
      namespace = "aws:ec2:vpc"
      value     = var.environment_type == "LoadBalanced" ? var.elb_scheme : ""
    },
    {
      name      = "HealthCheckInterval"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.healthcheck_interval
    },
    {
      name      = "HealthyThresholdCount"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.healthcheck_healthy_threshold_count
    },
    {
      name      = "UnhealthyThresholdCount"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value     = var.healthcheck_unhealthy_threshold_count
    }
  ]

  alb_settings = var.loadbalancer_access_logs_s3_enabled ? concat(local.alb_default_settings, local.alb_logs_settings) : local.alb_default_settings

  # Select elb configuration depending on loadbalancer_type
  elb_settings_nlb        = var.loadbalancer_type == "network" ? concat(local.nlb_settings, local.generic_elb_settings, local.beanstalk_elb_settings) : []
  elb_settings_alb        = var.loadbalancer_type == "application" && !var.loadbalancer_is_shared ? concat(local.alb_settings, local.generic_alb_settings, local.generic_elb_settings, local.beanstalk_elb_settings) : []
  elb_settings_shared_alb = var.loadbalancer_type == "application" && var.loadbalancer_is_shared ? concat(local.shared_alb_settings, local.generic_alb_settings, local.generic_elb_settings) : []

  # If the tier is "WebServer" add the elb_settings, otherwise exclude them
  elb_settings_final = var.eb_tier == "WebServer" ? concat(local.elb_settings_nlb, local.elb_settings_alb, local.elb_settings_shared_alb) : []

  eb_defaults = var.eb_platform == "dotnet" ? concat(local.eb_default_settings, local.eb_dotnet_settings) : local.eb_default_settings

  # Grab all elastic beanstalk settings
  eb_settings = concat(local.eb_defaults, local.eb_vpc, local.eb_asg, local.eb_launch_config, local.eb_cloudwatch)

  # Put all settings together
  eb_settings_final = concat(local.eb_settings, local.elb_settings_final)
}

resource "aws_elastic_beanstalk_application" "app" {
  count       = var.eb_application_name == "" ? 1 : 0
  name        = var.name
  description = "${var.name} EB APP"
}

resource "aws_elastic_beanstalk_environment" "env" {
  name                   = "${var.name}-${var.environment}"
  cname_prefix           = var.eb_tier == "WebServer" ? "${var.name}-${var.environment}" : null
  application            = var.eb_application_name == "" ? aws_elastic_beanstalk_application.app[0].name : var.eb_application_name
  solution_stack_name    = length(try(data.aws_elastic_beanstalk_solution_stack.solution_stack[0].name, "")) > 0 ? data.aws_elastic_beanstalk_solution_stack.solution_stack[0].name : var.eb_solution_stack_name
  description            = var.description
  tier                   = var.eb_tier
  wait_for_ready_timeout = var.eb_wait_for_ready_timeout
  version_label          = var.eb_version_label

  dynamic "setting" {
    for_each = local.eb_settings_final
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
      resource  = ""
    }
  }

  # Add additional Elastic Beanstalk settings
  # For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html
  dynamic "setting" {
    for_each = var.additional_settings
    content {
      namespace = setting.value.namespace
      name      = setting.value.name
      value     = setting.value.value
      resource  = ""
    }
  }

  lifecycle {
    ignore_changes = [
      cname_prefix,
      version_label,
      setting,
      solution_stack_name,
      wait_for_ready_timeout
    ]
  }
}

data "aws_elastic_beanstalk_solution_stack" "solution_stack" {
  count       = length(var.solutions_stack_name_regex) > 0 ? 1 : 0
  most_recent = true

  name_regex = var.solutions_stack_name_regex
}
