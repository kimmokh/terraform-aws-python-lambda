provider "aws" {
  region = "eu-north-1"
  # profile = "myprofile"
}

resource "aws_lambda_function" "lambda_function" {
  role = aws_iam_role.lambda_role.arn
  handler = var.handler
  runtime = var.runtime
  filename = "lambda.zip"
  function_name = var.function_name
  source_code_hash = filebase64sha256("lambda.zip")
  environment {
    variables = {
      "S3_BUCKET" = var.s3_bucket
    }
  }
}

data aws_iam_policy_document lambda_assume_role {
  statement {
    actions = [
      "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"]
    }
  }
}

resource aws_s3_bucket intake {
  bucket = var.s3_bucket
  acl = "private"

  tags = {
    environment = "development"
    project = "tf-study"
  }
}

data aws_iam_policy_document lambda_s3 {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket}/*"
    ]
  }
}

resource aws_iam_role lambda_role {
  name = "lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource aws_iam_policy lambda_s3 {
  name = "lambda-s3-permissions"
  description = "Contains S3 put/get permission for lambda"
  policy = data.aws_iam_policy_document.lambda_s3.json
}

resource aws_iam_role_policy_attachment lambda_s3 {
  role = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_s3.arn
}