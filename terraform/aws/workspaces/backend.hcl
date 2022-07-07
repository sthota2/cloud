# Backend.hcl config
bucket = "tf-state-bucket-dthota"
region = "us-east-1"
dynamodb_table = "dynamodb-table-tf-state-lock"
encrypt        = "true"