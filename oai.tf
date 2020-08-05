#Acces Control for SPA Bucket
resource "aws_cloudfront_origin_access_identity" "oai_spa" {
     comment = "origin_access_identity for SPA "
}

data "aws_iam_policy_document" "oai_spa_policy" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.oai_spa.iam_arn}"]
    }
    resources = ["${aws_s3_bucket.spa-app-bkt.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "oai_spa_policy" {
  bucket = aws_s3_bucket.spa-app-bkt.id
  policy = data.aws_iam_policy_document.oai_spa_policy.json
}

#Acces Control for Static Data Bucket
resource "aws_cloudfront_origin_access_identity" "oai_static_data" {
     comment = "origin_access_identity for Static Data Bucket "
}

data "aws_iam_policy_document" "oai_static_data_policy" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.oai_static_data.iam_arn}"]
    }
    resources = ["${aws_s3_bucket.static-data-bkt.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "oai_static_data_policy" {
  bucket = aws_s3_bucket.static-data-bkt.id
  policy = data.aws_iam_policy_document.oai_static_data_policy.json
}