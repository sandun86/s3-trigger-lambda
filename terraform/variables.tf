variable "environment" {
  type    = string
  default = "development"
}

variable "project_name" {
  type    = string
  default = "s3-trigger"
}

variable "s3_trigger_csv" {
  type    = string
  default = "s3-trigger-csv/"
}

variable "s3_trigger_mkv" {
  type    = string
  default = "s3-trigger-mkv/"
}
