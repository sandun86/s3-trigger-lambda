data "aws_iam_policy_document" "s3-trigger-lambda-csv" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
        #secretsmanager variables
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.s3_bucket["${var.environment}-${var.project_name}"].arn}/s3-trigger-csv/*",
    ]
  }
}

data "aws_iam_policy_document" "s3-trigger-lambda-mkv" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
        #secretsmanager variables
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.s3_bucket["${var.environment}-${var.project_name}"].arn}/s3-trigger-mkv/*",
    ]
  }
}