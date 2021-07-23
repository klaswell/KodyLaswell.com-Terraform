provider "aws" {
  alias = "acm"
  region = "us-east-1"
}

resource "aws_acm_certificate" "certificate" {
  domain_name               = "kodylaswell.com"
  subject_alternative_names = ["www.kodylaswell.com"]
  validation_method         = "DNS"
  provider                  = aws.acm

  tags = {
    Deployment = "Terraform"
  }
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.record : record.fqdn]
  provider                = aws.acm
}