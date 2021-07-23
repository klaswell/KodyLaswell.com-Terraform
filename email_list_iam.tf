resource "aws_iam_role" "iam_for_email_list_lambda" {
  name                = "EmailListLambda"
  assume_role_policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy-attach-email-list" {
  role       = "${aws_iam_role.iam_for_email_list_lambda.name}"
  policy_arn = "${data.aws_iam_policy.DynamoDBFullAccess.arn}"
}