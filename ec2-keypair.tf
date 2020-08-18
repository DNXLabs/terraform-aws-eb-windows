resource "tls_private_key" "this" {
  count     = var.key_name == "" ? 1 : 0
  algorithm = "RSA"
}

resource "aws_key_pair" "key" {
  count      = var.key_name == "" ? 1 : 0
  key_name   = "eb-${var.environment}-${var.name}"
  public_key = tls_private_key.this[0].public_key_openssh
}

resource "aws_ssm_parameter" "ssh_private_key_pem" {
  count = var.key_name == "" ? 1 : 0
  name  = "/eb/${var.environment}/${var.name}/ssh_private_key_pem"
  type  = "SecureString"
  value = tls_private_key.this[0].private_key_pem
}

resource "aws_ssm_parameter" "ssh_public_key_pem" {
  count = var.key_name == "" ? 1 : 0
  name  = "/eb/${var.environment}/${var.name}/ssh_public_key_pem"
  type  = "SecureString"
  value = tls_private_key.this[0].public_key_pem
}

resource "aws_ssm_parameter" "ssh_public_key_openssh" {
  count = var.key_name == "" ? 1 : 0
  name  = "/eb/${var.environment}/${var.name}/ssh_public_key_openssh"
  type  = "SecureString"
  value = tls_private_key.this[0].public_key_openssh
}