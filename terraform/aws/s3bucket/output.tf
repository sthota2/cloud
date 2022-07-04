# out puts
output "s3_bucket_arn" {
  value = aws_s3_bucket.my_s3_bucket.arn
  description = "The ARN of the S3 Bucket"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.my_dynamodb_table.name
  description = "The Name of the DynamoDB Table"
}