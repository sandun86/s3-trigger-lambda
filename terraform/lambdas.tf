locals {
  lambdas = {
    s3-trigger-lambda-csv = {
      description                    = "S3 bucket is triggering after uploading the CSV"
      handler                        = "index.handler"
      memory_size                    = 512
      reserved_concurrent_executions = -1
      runtime                        = "nodejs20.x"
      publish                        = true
      timeout                        = 30
      environment_variables = {
        development = {
          NODE_NO_WARNINGS              = 1
          ENVIRONMENT                   = var.environment
          S3_CSV_BUCKET                 = var.s3_trigger_csv
        }
        staging = {
            #variables
        }
        production = {
            #variables
        }
      }
    }
  }
}