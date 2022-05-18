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

output "alb_dns_name" {
  value       = aws_alb.my_alb.dns_name
  description = "The Domain Name of the load balancer"

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
  name                 = "tf-web-autoscaling-group"
  launch_configuration = aws_launch_configuration.my_launch_config.name
  vpc_zone_identifier  = data.aws_subnet_ids.my_subnet.ids

  target_group_arns = [aws_alb_target_group.my_alb_target_group.arn]
  health_check_type = "ELB"
  min_size          = 2
  max_size          = 4

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


/*Create application Load balancer */
resource "aws_alb" "my_alb" {
  name               = "deepni-application-load-balancer"
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.my_subnet.ids
  security_groups    = [aws_security_group.my_alb_security_group.id]

}

resource "aws_alb_listener" "my_alb_listener" {
  load_balancer_arn = aws_alb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  # Retrun default action
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }

}

resource "aws_security_group" "my_alb_security_group" {
  name = "alb_security_group"
  # Inbound rules
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  # Outbound rules
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

}

resource "aws_alb_target_group" "my_alb_target_group" {
  name     = "tf-alb-target-group"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.my_vpc.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

}
resource "aws_alb_listener_rule" "my_alb_listner_rule" {
  listener_arn = aws_alb_listener.my_alb_listener.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }

  }
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.my_alb_target_group.arn
  }

}
