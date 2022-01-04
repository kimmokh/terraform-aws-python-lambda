# Python AWS Lambda deployment with Terraform

PoC for deploying a Python AWS Lambda function with Terraform.

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
