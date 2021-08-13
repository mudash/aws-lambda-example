# AWS Lambda Example with Terraform and Spacelift

This example demonstrates how a sample Lambda function can be deployed to AWS via Terraform while gaining IaC CI/CD benefits from Spacelift.

## Environment
- Lambda function based on Go 
- Terraform resources to package and deploy to AWS
- Spacelift stack with private worker pool
- Customized container for Spacelift: public.ecr.aws/a5c1r7o1/bakery:latest

## Usage

This Lambda suggests a name for a newborn baby
```
aws lambda invoke \
  --cli-binary-format raw-in-base64-out \
  --function-name GetName \
  --payload '{}' \
  response.json

```
or you can pass the gender of your choice in payload as `{"Gender":"F"}` or `{"Gender":"F"}`

```
aws lambda invoke \
  --cli-binary-format raw-in-base64-out \
  --function-name GetName \
  --payload '{"Gender":"F"}' \
  response.json
```
The service response will be in `response.json` 

```
cat response.json

{"Name":"Aima"}
```

### Setup instructions

Coming in a blog post soon.