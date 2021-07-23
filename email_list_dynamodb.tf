resource "aws_dynamodb_table" "email_list_table" {
  name           = "email_list"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "EmailAddress"

  attribute {
    name = "EmailAddress"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }
}