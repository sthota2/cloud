provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "tf-state-bucket-dthota"
  # Prevent accidental deletion of the bucket
  lifecycle {
    prevent_destroy = false
  }

  # Enable versioning so that we have mutliple copies
  versioning {
    enabled = true
  }
  # Enable server side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Locks in Dynamo DB Tables
resource "aws_dynamodb_table" "my_dynamodb_table" {
  name         = "tf-state-bucket"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
