resource "aws_dynamodb_table" "cryptofibs-table" {
  name           = "cryptofibs"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "coin"

  attribute {
    name = "coin"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }
}