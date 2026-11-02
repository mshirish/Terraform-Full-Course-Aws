# Random suffix keeps the bucket name globally unique
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Task 1: Bucket name is prefixed with the environment (e.g. dev-tf-demo-bucket-abc123)
resource "aws_s3_bucket" "demo" {
  bucket = "${var.environment}-tf-demo-bucket-${random_string.suffix.result}"
}

# Latest Amazon Linux 2023 AMI in the selected region
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# Task 2: Create exactly var.instance_count instances
resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  # Task 3: Boolean flags
  monitoring                  = var.monitoring_enabled
  associate_public_ip_address = var.associate_public_ip

  tags = {
    Name = "${var.environment}-web-${count.index + 1}"
  }

  # Task 5: Fail the plan if the instance type is not approved
  lifecycle {
    precondition {
      condition     = contains(var.allowed_vm_types, var.instance_type)
      error_message = "Instance type \"${var.instance_type}\" is not allowed. Choose one of: ${join(", ", var.allowed_vm_types)}."
    }
  }
}

# Task 4: VPC uses the first CIDR in the list
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block[0]

  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Task 4: Subnets use the second and third CIDRs
resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block[1]

  tags = {
    Name = "${var.environment}-subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block[2]

  tags = {
    Name = "${var.environment}-subnet-b"
  }
}


# Task 8: Security group whose ingress rule comes from the tuple
resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Allow inbound traffic defined by ingress_values"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.ingress_values[0]
    protocol    = var.ingress_values[1]
    to_port     = var.ingress_values[2]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-web-sg"
  }
}

# Task 9: Instances driven by the config object
resource "aws_instance" "app" {
  count         = var.config.instance_count
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  monitoring    = var.config.monitoring

  tags = {
    Name = "${var.environment}-app-${count.index + 1}"
  }
}
