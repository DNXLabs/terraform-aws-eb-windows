data "aws_lb_listener" "selected_80" {
  load_balancer_arn = aws_elastic_beanstalk_environment.env.load_balancers[0]
  port              = 80
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  count = var.eb_tier == "WebServer" && var.environment_type == "LoadBalanced" && var.loadbalancer_type != "network" && !var.loadbalancer_is_shared ? 1 : 0
  listener_arn = data.aws_lb_listener.selected_80.arn

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
