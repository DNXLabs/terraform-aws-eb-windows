resource "aws_security_group" "eb" {
  count = var.create_security_group == true ? 1 : 0

  name = var.security_group_name

  description = var.security_group_description
  vpc_id      = var.vpc_id
  tags        = { Name = var.security_group_name }

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ingress.value.cidr_blocks
      self        = ingress.value.self
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      description = egress.value.description
      cidr_blocks = egress.value.cidr_blocks
      self        = egress.value.self
    }
  }
}