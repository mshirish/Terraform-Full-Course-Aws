# variable is a list of objects that define the ingress rules for the security group. 
# Each object contains the following attributes:
variable "ingress_rules" {
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    # The following are the default ingress rules for the security group.
    { port = 80,  protocol = "tcp", cidr_blocks = ["0.0.0.0/0"],  description = "HTTP" },
    { port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"],  description = "HTTPS" },
    { port = 22,  protocol = "tcp", cidr_blocks = ["10.0.0.0/8"], description = "SSH internal" },
  ]
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the security group will be created"
}