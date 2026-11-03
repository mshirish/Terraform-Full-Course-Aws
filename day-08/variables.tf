variable "bucket_names" {
  description = "Names of the S3 buckets to create"
  type        = list(string)
  default     = ["my-terraform-bucket", "my-terraform-bucket-2", "my-terraform-bucket-3"]
}

variable "bucket_names-foreach" {
  description = "Using foreach to create multiple S3 buckets"
  type        = set(string)
  default     = ["my-terraform-bucket-foreach", "my-terraform-bucket-foreach-2", "my-terraform-bucket-foreach-3"]
}