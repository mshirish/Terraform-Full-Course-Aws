terraform {
  required_version = ">= 1.12.0"
}

variable "environment" {
  type    = string
  default = "test"
}

resource "terraform_data" "study" {
  input = {
    environment = var.environment
    message     = "Terraform day 1"
  }
}

output "study_details" {
  value = terraform_data.study.output
}
