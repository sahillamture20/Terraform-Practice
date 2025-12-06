variable "region" {
  description = "AWS region for this project"
  type        = string
  default     = "ap-south-1"
}
variable "availability_zone" {
  description = "AWS availability zone for tis project"
  type        = list(any)
  default     = ["ap-south-1a", "ap-south-1b"]
}

#------------ INSTANCE VARIABLES STARTS HERE ------------

variable "instance_tags" {
  description = "Value of the EC2 instance's Name tag."
  type        = map(any)
  default = {
    "Name"        = "demo_inc"
    "Environment" = "Testing"
    "Project"     = "AWS-Infra-with-Terraform"
  }
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux AMI IDs used for instances for this project"
  type        = string
  default     = "ami-0d176f79571d18a8f"
}

#------------ VPC VARIABLES STARTS HERE ------------

variable "vpc_tags" {
  type = map(any)
  default = {
    "Name"        = "demo_vpc"
    "Environment" = "Testing"
    "Project"     = "AWS-Infra-with-Terraform"
  }
}
variable "cidr_blocks" {
  description = "List of cidr blocks used in VPC"
  type        = list(any)
  default     = ["10.0.0.0/16", "10.0.1.0/24", "10.0.2.0/24"]
}
