data "aws_route53_zone" "selected" {
  count = length(var.hostnames) > 0 ? 1 : 0
  name  = var.hosted_zone
}

resource "aws_route53_record" "hostname" {
  for_each = toset(var.hostnames)

  zone_id = data.aws_route53_zone.selected.*.zone_id[0]
  name    = each.key
  type    = "CNAME"
  ttl     = "300"
  records = tolist([aws_elastic_beanstalk_environment.env.cname])
}
