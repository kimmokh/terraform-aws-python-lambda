import json
import os

import boto3
import botocore

s3 = boto3.resource('s3')
the_bucket = s3.Bucket('my_bucket')


def append_to_s3(data):
    bucket = os.environ.get("S3_BUCKET")
    try:
        # TODO hourly buckets
        s3_object = s3.Object(bucket, 'data.csv').get()
        current_data = s3_object['Body'].read().decode('utf-8')

    except botocore.exceptions.ClientError:
        current_data = ""

    # TODO timestamp
    new_data = f"{current_data}{data}\n"

    # TODO concurrent modification
    s3.Object(bucket, 'data.csv').put(
        Body=(bytes(new_data.encode('UTF-8')))
    )


def validate_data(data):
    # TODO validation
    pass


def handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    status_code = 200
    try:
        if 'data' in event:
            validate_data(event['data'])
            append_to_s3(event['data'])
            result = 'success'
        else:
            result = 'data not found'
            status_code = 400
    except Exception as err:
        status_code = 500
        result = f"Unexpected {err=}, {type(err)=}"

    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "Status ": result
        })
    }
