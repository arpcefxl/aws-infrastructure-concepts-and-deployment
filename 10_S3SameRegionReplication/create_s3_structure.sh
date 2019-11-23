#!/bin/bash

#Set all the variables
PROFILE=
BUCKET1=
BUCKET2=
REGION=

#Create the two buckets
aws s3api --profile $PROFILE create-bucket --bucket $BUCKET1 --region $REGION
aws s3api --profile $PROFILE create-bucket --bucket $BUCKET2 --region $REGION

#Populate the first bucket
aws s3 --profile $PROFILE cp bucket1/ s3://$BUCKET1 --recursive

#Enable bucket versioning on both buckets
aws s3api --profile $PROFILE put-bucket-versioning --bucket $BUCKET2 --versioning-configuration --region $REGION
aws s3api --profile $PROFILE put-bucket-versioning --bucket $BUCKET1 --versioning-configuration --region $REGION


