locals {
  s3_origin_id = "kodylaswell.com"
}

#resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
#  comment = "Terraform issue 7930 workaround"
#}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.bucket.website_endpoint}"
    origin_id   = local.s3_origin_id

 #   s3_origin_config {
 #     origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
 #   }

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Deployed by Terraform"
  default_root_object = "index.html"

  aliases = ["kodylaswell.com", "www.kodylaswell.com"]

#  logging_config {
#    include_cookies = false
#    bucket          = ""
#    bucket          = "mylogs.s3.amazonaws.com"
#    prefix          = "myprefix"
#  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
  #  default_ttl            = 3600
  #  max_ttl                = 86400
    compress               = true

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.certificate.arn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}