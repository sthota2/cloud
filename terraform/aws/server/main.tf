# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Define security list
resource "aws_security_group" "my_web_security_group" {
  name        = "terraform-example"
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


}


# Create EC2 instance from AMID
resource "aws_instance" "my_ec2" {
  ami                    = "ami-09d56f8956ab235b3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_web_security_group.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello, World this is Deepni's WebSite" > index.html
  nohup busybox httpd -f -p 8080 &
  EOF


  tags = {
    Name = "terraform_example"
  }

}

