provider "aws" {
  region = var.aws_region
}

#Crear el bucket
resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name
}

#Configurar el bucket para hosting de sitio web
resource "aws_s3_bucket_website_configuration" "site_config" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }
}

#Quitar el bloqueo de acceso público (necesario para sitios web)
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.static_site.id
  depends_on = [aws_s3_bucket_public_access_block.public_block]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      },
    ]
  })
}
