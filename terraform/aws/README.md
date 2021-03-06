<!-- README DOCUMENT -->
# Getting started with AWS

## Sign up for account:
Pre-req's: email id, credit or debit card details.
ensure you have aws account, if not go to [AWS](https://aws.amazon.com/console/) sign up.
Based on your location you will see default landing region.

## Security best practices
Default user is root user, enable MFA and create another user and assign Admin Role

## Steps to create new user
login to aws console and go to IAM and click add user, in the user name field provide details, example:terraform-aws
select credential type ,Access key - Programmatic access, which has the below usage.
Enables an access key ID and secret access key for the AWS API, CLI, SDK, and other development tools.
click on next permissions and assign Administrator Group, click next on the tags
for key provide user_type, and value api, click next and create user, once the user is created Access Key ID & Secret key will be displayed, copy the values to secure location. 
*Note: Secret key will be displayed only once.*

## Install aws cli
Based on the OS please install aws cli reference document [Getting Started](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Setup aws credentials file
Pre-req: aws cli
Refer [cli-configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
execute command aws configure to setup
verify by 
```
aws s3 ls
```
view config file location by 
```
aws configure list
```

## AWS Terminlogy 
Plain english AWS Terminlogy refer [Plain English](https://expeditedsecurity.com/aws-in-plain-english/)

## CDIR Helpful
Handy Calculator that converts IP Address to CIDR Notation refer [CDIR](https://cidr.xyz/)





