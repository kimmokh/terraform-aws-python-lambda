variable "function_name" {
  type = string
  description = "The name of the Lambda function"
  default = "minimal_python_lambda_function"
}

variable "handler" {
  type = string
  description = "The name of the handler function."
  default = "lambda.handler"
}

variable "runtime" {
  type = string
  description = "The runtime environment for the Lambda function"
  default = "python3.8"
}

variable "s3_bucket" {
  type = string
  description = "The S3 bucket where the Lambda uploads intake data"
  default = "my-intake-test-bucket"
}