# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
    ami = "ami-09d56f8956ab235b3"

    # Conditional set
    instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
}