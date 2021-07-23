resource "aws_acm_certificate" "cryptofibs_v2_certificate" {
  domain_name               = "cryptofibs.kodylaswell.com"
  subject_alternative_names = ["www.cryptofibs.kodylaswell.com"]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "cryptofibs_v2_certificate_validation" {
  certificate_arn         = aws_acm_certificate.cryptofibs_v2_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cryptofibs_v2_validation : record.fqdn]
}