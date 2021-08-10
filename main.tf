provider "aws" {
  region = "us-east-1"
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name  = "get-baby-name"
  description   = "Lambda function that suggests a baby girl name"
  create_package = false

  image_uri    = module.docker_image.image_uri
  package_type = "Image"
}

module "docker_image" {
  source = "terraform-aws-modules/lambda/aws//modules/docker-build"

  create_ecr_repo = true
  ecr_repo        = "my-ecr-repo"
  image_tag       = "1.0"
  source_path     = "go-func"
}
