locals {
  buckets = {
    "${var.environment}-${var.project_name}" = {
      versioning_enabled = "Enabled"
    }
  }

  events = {
    s3-trigger-csv = {
      bucket        = "${var.environment}-${var.project_name}"
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = "s3-trigger-csv/"
      filter_suffix = "csv"
      lambda        = "s3-trigger-lambda-csv"
    }
    s3-trigger-mkv = {
      bucket        = "${var.environment}-${var.project_name}"
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = "s3-trigger-mkv/"
      filter_suffix = "mkv"
      lambda        = "s3-trigger-lambda-mkv"
    }
  }

  permissions = {
    s3-trigger-event = {
      statement_id = "AllowExecutionFromS3Bucket"
      action       = "lambda:InvokeFunction"
      lambda       = "s3-trigger-lambda"
      principal    = "s3.amazonaws.com"
      bucket       = "${var.environment}-${var.project_name}"
    }
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  for_each = local.buckets
  bucket   = format("%.255s", lower("${each.key}"))
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  for_each = local.buckets
  bucket   = aws_s3_bucket.s3_bucket[each.key].id
  acl      = "private"
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  for_each = local.buckets
  bucket   = aws_s3_bucket.s3_bucket[each.key].id
  versioning_configuration {
    status = each.value["versioning_enabled"]
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  for_each = local.events
  bucket   = format("%.255s", lower("${each.value["bucket"]}"))
  #foreach should here
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambdas["s3-trigger-lambda-csv"].arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "s3-trigger-csv/"
    filter_suffix       = "csv"
  }

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambdas["s3-trigger-lambda-mkv"].arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "s3-trigger-mkv/"
    filter_suffix       = "mkv"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_permission" "allow_bucket" {
  for_each      = local.permissions
  statement_id  = each.value["statement_id"]
  action        = each.value["action"]
  function_name = aws_lambda_function.lambdas[each.value.lambda].arn
  principal     = each.value["principal"]
  source_arn    = aws_s3_bucket.s3_bucket[each.value.bucket].arn
}

