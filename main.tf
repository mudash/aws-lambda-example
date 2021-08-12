provider "aws" {
  region = "us-east-1"
}

resource "random_pet" "go_func_bucket_name" {
  prefix = "go-lambda"
  length = 2
}

resource "aws_s3_bucket" "go_func_bucket" {
  bucket = random_pet.go_func_bucket_name.id

  acl           = "private"
  force_destroy = true
}

data "archive_file" "go_func_archive" {
  type = "zip"

  source_file      = "${path.module}/bin/get-name" 
  output_path = "${path.module}/bin/get-name.zip"
}

resource "aws_s3_bucket_object" "go_func_bucket_item" {
  bucket = aws_s3_bucket.go_func_bucket.id

  key    = "get-name.zip"
  source = data.archive_file.go_func_archive.output_path

  etag = filemd5(data.archive_file.go_func_archive.output_path)
}

resource "aws_lambda_function" "get_name" {
  function_name = "GetName"

  s3_bucket = aws_s3_bucket.go_func_bucket.id
  s3_key    = aws_s3_bucket_object.go_func_bucket_item.key

  runtime = "go1.x"
  handler = "get-name"

  source_code_hash = filebase64sha256(data.archive_file.go_func_archive.output_path)

  role = aws_iam_role.go_lambda_role.arn
}

resource "aws_iam_role" "go_lambda_role" {
  name = "go_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.go_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


output "lambda_bucket_name" {
  description = "S3 bucket name for Go lambda function"

  value = aws_s3_bucket.go_func_bucket.id
}
