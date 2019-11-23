#!/bin/python
import boto3

client = boto3.resource('s3')

destination_bucket = "BUCKET2"
source_bucket = "BUCKET1"

for key in s3.list_objects(Bucket=source_bucket)['Contents']:
    files = key['Key']
    copy_source = {'Bucket': "source_bucket",'Key': files}
    client.meta.client.copy(copy_source, destination_bucket, files)
    print(files)
