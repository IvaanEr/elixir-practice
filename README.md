# AwsHelper

Mini function wrapper for communication with AWS. Just implement the get and upload of a file into an specific hardcoded bucket

> For the application to work you need to have the AWS credentials set in the environment like AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.

> The bucket is hardcoded as a @s3_bucket in aws_helper.ex

## Examples
Fetch the file from S3 bucket
```
iex> AwsHelper.get("my_file")
# File content string
```

Upload local file to S3 bucket
```
iex> AwsHelper.upload("my_file")
:ok

iex> AwsHelper.upload("non-existent-file")
:error
```