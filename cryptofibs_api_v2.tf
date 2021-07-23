resource "aws_apigatewayv2_api" "cryptofibs_v2_api" {
  name          = "cryptofibs v2"
  protocol_type = "HTTP"
  description   = "Deployed by Terraform"

  cors_configuration {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token"]
    allow_methods = ["POST", "OPTIONS"]
    allow_origins = ["*"]
  }

  route_key     = "POST /fib"
  target        = aws_lambda_function.cryptofibs_lambda.arn

  disable_execute_api_endpoint = "true"
}

resource "aws_apigatewayv2_domain_name" "cryptofibs_v2_domain_name" {
  domain_name     = "cryptofibs.kodylaswell.com"
  
  domain_name_configuration {
    certificate_arn = aws_acm_certificate_validation.cryptofibs_v2_certificate_validation.certificate_arn
    security_policy = "TLS_1_2"
    endpoint_type   = "REGIONAL"
  }
}

resource "aws_apigatewayv2_stage" "cryptofibs_v2_stage" {
  api_id      = aws_apigatewayv2_api.cryptofibs_v2_api.id
  name        = "prod"
  auto_deploy = "true"
}

resource "aws_apigatewayv2_api_mapping" "cryptofibs_v2_api_mapping" {
  api_id      = aws_apigatewayv2_api.cryptofibs_v2_api.id
  domain_name = aws_apigatewayv2_domain_name.cryptofibs_v2_domain_name.id
  stage       = aws_apigatewayv2_stage.cryptofibs_v2_stage.id
}