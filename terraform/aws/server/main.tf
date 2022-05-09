# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Define the variables
variable "server_port" {
  description = "The port the server will use for HTTP Requests"
  type        = number
  default     = 8080
}

# Define output variables
output "public_ip" {
  description = "The public ip address of the web server"
  value       = aws_instance.my_ec2.public_ip

}

# Define security list
resource "aws_security_group" "my_web_security_group" {
  name        = "terraform-example"
  description = "Security group for EC2 instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
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
  nohup busybox httpd -f -p ${var.server_port} &
  EOF


  tags = {
    Name = "terraform_example"
  }

}

resource "aws_launch_configuration" "my_launch_config" {
  name            = "web_config"
  image_id        = "ami-09d56f8956ab235b3"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.my_web_security_group.id]
  user_data       = <<-EOF
  #!/bin/bash
  echo "Hello, World this is Deepni's WebSite" > index.html
  nohup busybox httpd -f -p ${var.server_port} &
  EOF

  # Required when using launch configuration with ASG
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_autoscaling_group" {
  launch_configuration = aws_launch_configuration.my_launch_config.name
  vpc_zone_identifier  = data.aws_subnet_ids.my_subnet.ids
  min_size             = 1
  max_size             = 3

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }

}

data "aws_vpc" "my_vpc" {
  default = true
}

data "aws_subnet_ids" "my_subnet" {
  vpc_id = data.aws_vpc.my_vpc.id

}
