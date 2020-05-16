locals {

}

resource "aws_autoscaling_schedule" "ecs_stop" {
  count                  = var.enable_schedule ? 1 : 0
  scheduled_action_name  = "eb-${var.name}-${var.environment}-stop"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  autoscaling_group_name = aws_elastic_beanstalk_environment.env.autoscaling_groups[0]
  recurrence             = var.schedule_cron_stop
}

resource "aws_autoscaling_schedule" "ecs_start" {
  count                  = var.enable_schedule ? 1 : 0
  scheduled_action_name  = "eb-${var.name}-${var.environment}-start"
  min_size               = var.asg_min
  max_size               = var.asg_max
  desired_capacity       = var.asg_min
  autoscaling_group_name = aws_elastic_beanstalk_environment.env.autoscaling_groups[0]
  recurrence             = var.schedule_cron_start
}
