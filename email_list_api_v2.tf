resource "aws_apigatewayv2_api" "email_list_v2_api" {
  name          = "email list v2"
  protocol_type = "HTTP"
  description   = "Deployed by Terraform"

  cors_configuration {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token"]
    allow_methods = ["POST", "OPTIONS"]
    allow_origins = ["*"]
  }

  route_key                    = "POST /add"
  target                       = aws_lambda_function.email_list_lambda.arn
  disable_execute_api_endpoint = "true"
}

resource "aws_apigatewayv2_domain_name" "email_list_v2_domain_name" {
  domain_name     = "emaillist.kodylaswell.com"
#  depends_on = [
#    aws_acm_certificate_validation.cryptofibs_v2_certificate_validation,
#    aws_acm_certificate.cryptofibs_v2_certificate
#  ]
  domain_name_configuration {
    certificate_arn = aws_acm_certificate_validation.email_list_v2_certificate_validation.certificate_arn
    security_policy = "TLS_1_2"
    endpoint_type   = "REGIONAL"
  }
}

resource "aws_apigatewayv2_stage" "email_list_v2_stage" {
  api_id = aws_apigatewayv2_api.email_list_v2_api.id
  name   = "prod"
  auto_deploy = "true"
}

resource "aws_apigatewayv2_api_mapping" "email_list_v2_api_mapping" {
  api_id      = aws_apigatewayv2_api.email_list_v2_api.id
  domain_name = aws_apigatewayv2_domain_name.email_list_v2_domain_name.id
  stage       = aws_apigatewayv2_stage.email_list_v2_stage.id
}