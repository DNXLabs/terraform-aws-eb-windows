
resource "aws_ssm_association" "join_domain_automation" {
  count = var.ad_directory_name == "" ? 0 : 1
  name  = aws_ssm_document.automation[0].name
}

output "ssm_association_join_domain_automation" {
  value = try(aws_ssm_association.join_domain_automation[0].association_id, "")
}

resource "aws_ssm_parameter" "ssm_association" {
  count = var.ad_directory_name == "" ? 0 : 1
  name  = "eb-${var.name}-${var.environment}-automation-association-id"
  type  = "String"
  value = aws_ssm_association.join_domain_automation[0].association_id
}

resource "aws_ssm_document" "join_domain" {
  count         = var.ad_directory_name == "" ? 0 : 1
  name          = "eb-${var.name}-${var.environment}-join-domain"
  document_type = "Command"

  content = <<DOC
  {
    "schemaVersion":"1.2",
    "description":"Join instances to an AWS Directory Service domain.",
    "runtimeConfig":{
        "aws:domainJoin":{
          "properties":{
            "directoryId":"${var.ad_directory_id}",
            "directoryName":"${var.ad_directory_name}",
            "dnsIpAddresses":[
              "${var.ad_directory_ip1}",
              "${var.ad_directory_ip2}"
            ]
          }
        }
    }
  }
DOC
}

resource "aws_ssm_document" "change_hostname" {
  count         = var.ad_directory_name == "" ? 0 : 1
  name          = "eb-${var.name}-${var.environment}-hostname"
  document_type = "Command"

  content = <<DOC
  {
    "schemaVersion":"2.0",
    "description":"Run a Shell script to securely Changing the hostname for Windows instance",
    "mainSteps":[
      {
        "action":"aws:runPowerShellScript",
        "name":"runPowerShellScript",
        "inputs":{
          "runCommand":[
          "$currenthostname = hostname\n",
          "$instanceId = ((Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/instance-id -UseBasicParsing).Content)\n",
          "Rename-computer –computername \"$currenthostname\" –newname \"$instanceId\" -Force -Restart\n"
          ]
        }
      }
    ]
   }
DOC
}

resource "aws_iam_role" "automation" {
  count = var.ad_directory_name == "" ? 0 : 1
  name  = "eb-${var.name}-${var.environment}-automation"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com", "ssm.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "automation" {
  count      = var.ad_directory_name == "" ? 0 : 1
  role       = aws_iam_role.automation[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
}

resource "aws_ssm_document" "automation" {
  count           = var.ad_directory_name == "" ? 0 : 1
  name            = "eb-${var.name}-${var.environment}-automation"
  document_type   = "Automation"
  document_format = "YAML"
  content         = <<DOC
schemaVersion: '0.3'
assumeRole: ${aws_iam_role.automation[0].arn}
mainSteps:
  - name: initial_sleep
    action: aws:sleep
    inputs:
      Duration: PT10M
  - name: change_hostname
    action: 'aws:runCommand'
    inputs:
      DocumentName: ${aws_ssm_document.change_hostname[0].name}
      Targets:
        - Key: tag:Name
          Values:
            - ${var.name}-${var.environment}
  - name: sleep
    action: aws:sleep
    inputs:
      Duration: PT1M
  - name: join_domain
    action: 'aws:runCommand'
    inputs:
      DocumentName: ${aws_ssm_document.join_domain[0].name}
      Targets:
        - Key: tag:Name
          Values:
            - ${var.name}-${var.environment}
DOC
}
