resource "aws_s3_bucket" "static-data-s3" {
  bucket = "xyz-gmbh-static-data"
  acl    = "private"

  tags = {
    Description        = "S3 Bucket to store static data used by js application"
    Environment = "dev"
  }
}