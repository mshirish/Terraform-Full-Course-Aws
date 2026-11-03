output "bucket_names" {
  description = "List of S3 bucket names created"
  value       = concat(
    [for bucket in aws_s3_bucket.count-demo : bucket.bucket],
    [for bucket in aws_s3_bucket.foreach-demo : bucket.bucket]
    )
}

output "bucket_ids" {
  description = "List of S3 bucket IDs created using for_each"
  value       = concat(
    [for bucket in aws_s3_bucket.count-demo : bucket.id],
    [for bucket in aws_s3_bucket.foreach-demo : bucket.id]
    )
}