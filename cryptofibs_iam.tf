data "aws_iam_policy" "DynamoDBFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role" "iam_for_cryptofibs_lambda" {
  name                = "CryptoFibsLambda"
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

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = "${aws_iam_role.iam_for_cryptofibs_lambda.name}"
  policy_arn = "${data.aws_iam_policy.DynamoDBFullAccess.arn}"
}