# Task 1: String constraints
variable "environment" {
  description = "Environment name, used as a prefix for resource names"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"

  # Task 6: Only allow regions from the approved set
  validation {
    condition     = contains(var.allowed_region, var.region)
    error_message = "Region \"${var.region}\" is not allowed. Choose one of: ${join(", ", var.allowed_region)}."
  }
}

# Task 2: Number constraint
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}
# Task 3: Boolean constraints
variable "monitoring_enabled" {
  description = "Enable detailed CloudWatch monitoring on EC2 instances"
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  description = "Assign a public IP address to EC2 instances at launch"
  type        = bool
  default     = true
}

# Task 4: List(string) constraint
# [0] = VPC CIDR, [1] and [2] = subnet CIDRs (must fall inside the VPC range)
variable "cidr_block" {
  description = "CIDR blocks: VPC first, then one per subnet"
  type        = list(string)
  default     = ["10.0.0.0/16", "10.0.1.0/24", "10.0.2.0/24"]
}

# Task 5: List(string) as an allow-list
variable "allowed_vm_types" {
  description = "EC2 instance types approved for use"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t3.micro", "t3.small"]
}

variable "instance_type" {
  description = "EC2 instance type (must be in allowed_vm_types)"
  type        = string
  default     = "t3.micro"
}

# Task 6: Set(string) of approved regions
variable "allowed_region" {
  description = "AWS regions approved for deployment"
  type        = set(string)
  default     = ["us-east-1", "us-east-2", "eu-west-1"]
}

# Task 7: Map(string) of resource tags
variable "tags" {
  description = "Tags applied to the VPC"
  type        = map(string)
  default = {
    Environment = "dev"
    Name        = "dev-Instance"
    created_by  = "terraform"
  }
}

# Task 8: Tuple constraint - [from_port, protocol, to_port]
variable "ingress_values" {
  description = "Ingress rule as [from_port, protocol, to_port]"
  type        = tuple([number, string, number])
  default     = [443, "tcp", 443]
}

# Task 9: Object constraint - related settings grouped together
variable "config" {
  description = "Deployment settings for the app instances"
  type = object({
    region         = string
    monitoring     = bool
    instance_count = number
  })
  default = {
    region         = "us-east-1"
    monitoring     = true
    instance_count = 1
  }

  # Keep the Task 6 region restriction now that the provider uses config.region
  validation {
    condition     = contains(var.allowed_region, var.config.region)
    error_message = "Region \"${var.config.region}\" is not allowed. Choose one of: ${join(", ", var.allowed_region)}."
  }
}