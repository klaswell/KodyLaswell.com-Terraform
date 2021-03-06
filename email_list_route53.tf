resource "aws_route53_record" "email_list_v2_a_record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "emaillist.kodylaswell.com"
  type    = "A"

  alias {
    name                   = aws_apigatewayv2_domain_name.email_list_v2_domain_name.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.email_list_v2_domain_name.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "email_list_v2_validation" {
  for_each = {
    for dvo in aws_acm_certificate.email_list_v2_certificate.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
}