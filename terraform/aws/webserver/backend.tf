/* Configure the backend config, to use S3 for state & Dynamo DB for Locking */
terraform {
  backend "s3" {
    # Replace this with the bucket name name
    bucket = "tf-state-bucket-dthota"
    key    = "s3/webserver/terraform.tfstate"
    region = "us-east-1"

    # Replace this with Dynamo DB Table
    dynamodb_table = "dynamodb-table-tf-state-lock"
    encrypt        = "true"
  }
}
