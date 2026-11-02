# Input Variables - Values provided to Terraform configuration
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "my-terraform-bucket"
}

variable "region" {
    description "Default region"
    type = string
    default = "us-east-2"
}

variable "project_name" {
  description = "Terraform-Demo"
  type        = string
}