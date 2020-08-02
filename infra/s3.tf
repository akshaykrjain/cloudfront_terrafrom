resource "aws_s3_bucket" "spa-bucket" {
  bucket = "xyz-gmbh-app-scripts"
  acl    = "private"

  tags = {
    Description = "S3 Bucket to store application java scripts"
    Environment = "dev"
  }
}

resource "aws_s3_bucket" "static-data-bucket" {
  bucket = "xyz-gmbh-static-data"
  acl    = "private"

  tags = {
    Description = "S3 Bucket to store static data used by js application"
    Environment = "dev"
  }
}

resource "aws_s3_bucket" "logging-bucket" {
  bucket = "xyz-gmbh-logging-data"
  acl    = "private"

  tags = {
    Description = "S3 Bucket to store logs"
    Environment = "dev"
  }
}

