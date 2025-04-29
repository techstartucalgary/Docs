# Terraform

<img src="../images/terraform.png" alt="terraform logo" width="100"/>

## Overview

Previously, we mentioned the benefits of using Infrastructure as Code (IaC) for creating and deploying your Lambda functions. One powerful solution for managing IaC is **Terraform**!

Terraform, developed by HashiCorp, is an open-source tool that enables you to define and provision infrastructure using a simple, human-readable configuration language. With Terraform, you can manage everything from cloud providers like AWS, Azure, and Google Cloud to on-premise resources and even SaaS integrations.

## Why Choose Terraform?

- **Declarative Configuration**: Focus on _what_ you want to achieve, and Terraform handles the _how_.
- **Version Control**: Treat infrastructure as code, keeping a record of changes alongside your application code.
- **Automation**: Reduce manual work by automating resource provisioning and updates.
- **State Management**: Terraform keeps track of your infrastructure's state, ensuring changes are safely applied.

## The Terraform Workflow

1. **Write**: Define your infrastructure using configuration files written in HCL (HashiCorp Configuration Language).
2. **Plan**: Preview the changes Terraform will make, ensuring predictability before execution.
3. **Apply**: Execute the changes to create, update, or destroy resources as specified in your configuration.
4. **Destroy**: Safely decommission resources when they're no longer required.

## Most Common Terraform Commands

Here are some of the most frequently used Terraform commands to get you started:

### Initialization

- `terraform init`: Prepares the working directory for other commands by downloading plugins and providers.

### Planning and Applying

- `terraform plan`: Generates an execution plan, showing what changes will be made to your infrastructure.
- `terraform apply`: Applies the changes required to reach the desired state defined in your configuration.

### State Management

- `terraform show`: Displays information about the Terraform state.
- `terraform state list`: Lists all resources in the current state.

### Resource Management

- `terraform validate`: Checks the syntax of your configuration files for errors.
- `terraform fmt`: Formats your configuration files to follow Terraform’s style conventions.

### Destroying Resources

- `terraform destroy`: Removes all infrastructure defined in your Terraform configuration.

## Getting Started with Terraform

Terraform has a user-friendly [documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started?product_intent=terraform) that can guide you step-by-step on how to start with AWS.

Here is an exmaple `main.tf` on how to deploy an AWS Lambda function from **[spacelift](https://spacelift.io/blog/terraform-aws-lambda)**

```bash
provider "aws" {
  region = "ca-central-1"
}
resource "aws_iam_role" "lambda_role" {
name   = "Spacelift_Test_Lambda_Function_Role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_policy" "iam_policy_for_lambda" {

 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

data "archive_file" "zip_the_python_code" {
type        = "zip"
source_dir  = "${path.module}/python/"
output_path = "${path.module}/python/hello-python.zip"
}

resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = "${path.module}/python/hello-python.zip"
function_name                  = "Spacelift_Test_Lambda_Function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "index.lambda_handler"
runtime                        = "python3.9"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}
```

## 📚 Further Reading

- **[Download Terraform](https://www.terraform.io/)**  
  Get the latest version of Terraform..

- **[Terraform Documentation](https://developer.hashicorp.com/terraform)**  
  Official HashiCorp Terraform documentation, including tutorials and examples.

- **[Getting Started with Terraform on AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started?product_intent=terraform)**  
  A step-by-step tutorial to set up and manage AWS infrastructure using Terraform.

- **[Terraform Cheat Sheet](https://github.com/scraly/terraform-cheat-sheet/blob/master/terraform-cheat-sheet.pdf)**  
  A handy PDF reference with Terraform commands and concepts.
