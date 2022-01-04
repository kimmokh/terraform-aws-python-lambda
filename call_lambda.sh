#!/usr/bin/env bash

set -e

aws lambda invoke --invocation-type RequestResponse --function-name minimal_python_lambda_function --payload '{ "data": "Zm9vCg==" }' --cli-binary-format raw-in-base64-out  response.json

cat  response.json | jq
