output "cloudfront_domain" {
  value = aws_cloudfront_distribution.web_distribution.*.domain_name
}