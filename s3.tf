resource "aws_s3_bucket" "bucket" {
  bucket = "kodylaswell.com"
  acl    = "public-read"
  
  website {
    index_document = "index.html"
	  error_document = "404.html"
  }
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = [
          "${aws_s3_bucket.bucket.arn}/*",
        ]
      },
    ]
  })
}