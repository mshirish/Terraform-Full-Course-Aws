# Task 7: Name tag read back from the VPC
output "vpc_name" {
  description = "Name tag of the VPC"
  value       = aws_vpc.main.tags["Name"]
}

# Task 10: Summary combining string, number and map values
output "deployment_summary" {
  description = "Overview of the deployment"
  value = {
    environment    = var.environment
    instance_count = var.instance_count
    name           = var.tags["Name"]
  }
}
