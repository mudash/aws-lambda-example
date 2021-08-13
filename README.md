# AWS Lambda Example with Terraform and Spacelift

This example demonstrates how a sample Lambda function can be deployed to AWS via Terraform while gaining IaC CI/CD benefits from Spacelift.

## Environment
- Lambda function based on Go 
- Terraform resources to package and deploy to AWS
- Spacelift stack with private worker pool
- Customized container for Spacelift: public.ecr.aws/a5c1r7o1/bakery:latest


