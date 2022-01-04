# Python AWS Lambda deployment with Terraform

PoC for deploying a Python AWS Lambda function with Terraform.

The lambda accepts JSON payload in following format:
```json
{
  "data": "<base64 encoded data>"
}
```

...and returns following responses:

OK:
```json
{
  "statusCode": 200,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": "{\"Status \": \"success\"}"
}
```

BAD_REQUEST:
```json
{
  "statusCode": 400,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": "{\"Status \": \"data not found\"}"
}
```

INTERNAL_ERROR:
```json
{
  "statusCode": 500,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": "{\"Status \": \"Unexpected <error description here (to be removed as this reveals bucket name etc.)>\"}"
}
```

**Build zip package**
```shell
$ ./build.sh
```

**Init environment**
```shell
$ terraform init
```

**Plan deployment**
```shell
$ terraform plan
```

**Deploy**
```shell
$ terraform apply
```

**Build and deploy with no questions asked**
```shell
$ ./build.sh
```

**Execute lambda**
```shell
$ ./call_lambda.sh
```
