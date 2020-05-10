data "aws_route53_zone" "selected" {
  count = var.hostname != "" ? 1 : 0
  name  = var.hosted_zone
}

resource "aws_route53_record" "hostname" {
  count = var.hostname != "" ? 1 : 0

  zone_id = data.aws_route53_zone.selected.*.zone_id[0]
  name    = var.hostname
  type    = "CNAME"
  ttl     = "300"
  records = list(aws_elastic_beanstalk_environment.env.cname)
}
