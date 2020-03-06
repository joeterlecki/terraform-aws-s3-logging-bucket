resource "aws_s3_bucket" "standard_bucket" {
  bucket = var.bucket_name
  region = var.region
  acl    = var.canned_acl
  tags   = local.tags
  versioning {
    enabled = var.versioning_status
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${var.bucket_name}"
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.standard_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

