resource "aws_dynamodb_table" "hello_world" {
  name           = "HelloWorld"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "SomeKey"
    type = "S"
  }

  hash_key = "SomeKey"
}

