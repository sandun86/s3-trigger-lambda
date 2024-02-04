resource "aws_iam_policy" "s3-trigger-lambda-csv" {
  policy = data.aws_iam_policy_document.s3-trigger-lambda-csv.json
}

resource "aws_iam_role_policy_attachment" "s3-trigger-lambda-csv" {
  policy_arn = aws_iam_policy.s3-trigger-lambda-csv.arn
  role       = aws_iam_role.lambdas["s3-trigger-lambda-csv"].name
}