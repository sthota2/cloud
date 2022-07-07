/* Configure the backend config, to use S3 for state & Dynamo DB for Locking */
terraform {
  backend "s3" {
    # Replace this with the bucket name name

    key = "s3/workspaces/terraform.tfstate"

  }
}
