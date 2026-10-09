variable "aws_region" {
  description = "AWS region in which to create the instance."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Optional AWS CLI profile name; leave empty to use the default credential chain."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.medium"
}

variable "instance_name" {
  description = "EC2 instance to deploy node js service"
  type        = string
  default     = "dockerized-service"
}
