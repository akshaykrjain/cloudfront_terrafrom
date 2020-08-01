resource "aws_s3_bucket" "app-s3" {
  bucket = "xyz-gmbh-app-scripts"
  acl    = "private"

  tags = {
    Description        = "S3 Bucket to store application java scripts"
    Environment = "dev"
  }
}