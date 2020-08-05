locals {
  spa_s3_origin_id = "spa_distribution_origin"
  static_data_s3_origin_id = "static-data_distribution_origin"
}

resource "aws_cloudfront_distribution" "web_distribution" {
  enabled             = true
  is_ipv6_enabled     = false
  wait_for_deployment = false
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  origin {
    domain_name = aws_s3_bucket.spa-app-bkt.bucket_regional_domain_name
    origin_id   = local.spa_s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai_spa.cloudfront_access_identity_path
    } 
  }

  origin {
    domain_name = aws_s3_bucket.static-data-bkt.bucket_regional_domain_name
    origin_id   = local.static_data_s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai_static_data.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.spa_s3_origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
      headers = ["Origin"]
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    
    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.edge_headers.qualified_arn
      include_body = false
    }
  }

    # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/static/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.static_data_s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }  
 
  aliases = [var.route53_domain]
  viewer_certificate {
    acm_certificate_arn      = var.acm_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  web_acl_id = aws_waf_web_acl.waf_acl.id

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}