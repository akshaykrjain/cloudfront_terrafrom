
resource "aws_s3_bucket" "spa-app-bkt" {
  bucket        = var.spa-app-bkt
  acl           = "private"
  force_destroy = var.s3_force_destroy
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "static-data-bkt" {
  bucket        = var.static-data-bkt
  acl           = "private"
  force_destroy = var.s3_force_destroy
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = var.spa-app-bkt
  key          = "index.html"
  source       = "initial_files/index.html"
  content_type = "text/html"
  depends_on = [
    aws_s3_bucket.spa-app-bkt,
  ]
}

resource "aws_s3_bucket_object" "error" {
  bucket       = var.spa-app-bkt
  key          = "error.html"
  source       = "initial_files/error.html"
  content_type = "text/html"
  depends_on = [
    aws_s3_bucket.spa-app-bkt,
  ]
}