variable "bucket_name" {
  description = "Nombre único del bucket de S3"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS donde se creará el bucket"
  type        = string
  default     = "us-east-1"
}
