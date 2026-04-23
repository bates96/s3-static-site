output "website_url" {
  value = aws_s3_bucket_website_configuration.site_config.website_endpoint
}

output "bucket_name" {
  value = aws_s3_bucket.static_site.id
}
