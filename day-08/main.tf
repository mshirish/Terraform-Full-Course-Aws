#Task 1: Create multiple S3 buckets using count parameter
resource "aws_s3_bucket" "count-demo" {
  count  = length(var.bucket_names)
  bucket = var.bucket_names[count.index]
}

resource "aws_s3_bucket" "foreach-demo" {
  for_each = var.bucket_names-foreach
  bucket   = each.value
}