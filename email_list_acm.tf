resource "aws_acm_certificate" "email_list_v2_certificate" {
  domain_name               = "emaillist.kodylaswell.com"
  subject_alternative_names = ["www.emaillist.kodylaswell.com"]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "email_list_v2_certificate_validation" {
  certificate_arn         = aws_acm_certificate.email_list_v2_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.email_list_v2_validation : record.fqdn]
}