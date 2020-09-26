data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "${path.module}/test.py"
    output_path   = "${path.module}/test.zip"
}
resource "aws_s3_bucket_object" "this" {
 bucket = "uganderkrishna"
 key    = "test.zip"
 source = "${path.module}/test.zip"
}
resource "aws_lambda_function" "test_lambda" {
  #filename         = "${path.module}/test.zip}"
  s3_bucket = "uganderkrishna"
  s3_key = "test.zip"
  function_name    = "test_lambda"
  role             = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler          = "index.handler"
#  source_code_hash = "test.zip.output_base64sha256"
#  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.7"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
