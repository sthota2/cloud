# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create EC2 instance from AMID
resource "aws_instance" "example" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform_example"
  }

}

