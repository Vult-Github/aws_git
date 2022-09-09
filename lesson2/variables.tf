variable "region" {
  type        = string
  description = "Work region"
  default     = "us-east-1"
}
variable "profile" {
  type        = string
  description = "Profile used"
  default     = "lessonvult"
}

variable "environment_type" {
  type        = string
  description = "Type of environment"
}

variable "projectname" {
  type        = string
  description = "Name of Project"
}

variable "ec2_instance_type" {
  type        = string
  description = "Type for EC2 instance"
  default     = "t2.micro"
}

variable "ec2_access_key" {
  type        = string
  description = "AWS key for EC2 access"
  default     = "Test_vult_aws"
}
