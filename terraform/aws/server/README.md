# Define provider
Refer provider aws from https://registry.terraform.io/providers/hashicorp/aws/latest/docs#example-usage

# EC2 Instance 
Refer EC2 instance creation from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
Image ID used is Ubuntu, Please note that busybox comes out of box in ubuntu

# User data
Refer user data options from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#user_data

# Multiline 
Refer <<-EOF syntax from https://www.terraform.io/language/configuration-0-11/syntax

# Security Group
Refer Security group creation from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

# Terraform Graph
execute the terraform graph and paste the output in graphvizonline https://dreampuf.github.io/GraphvizOnline/

# Terraform input variable
terraform type number is used for server port, for more input types refer https://www.terraform.io/language/expressions/typeste

# Terrform output variable
get the public ip of the EC2 instance, for more info refer https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#public_ip

# Launch Configuration
To Create Launch Configuration, we need the image ID,EC2 instance & life cycle to create before destroy set to true, refer https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration

# Auto Scaling Group
To Create Auto Scaling Group refer https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group

# Data Source
To get the data out of the data source, you can use the following syntax
data.<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
