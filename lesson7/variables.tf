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

variable "lesson_number" {
  type        = string
  description = "Number of aws lesson"
  default     = "unknown"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for VPC"
}

variable "subnet_public_cidr" {
  type        = string
  description = "CIDR for subnet public"
}

variable "subnet_availib_zone" {
  type        = string
  description = "Availability zone for subnets"
}

variable "ec2_inner_key" {
  type        = string
  description = "Key for access to CA"
}

variable "ec2_ca_ip" {
  type        = string
  description = "ip of CA VM"
}

variable "ec2_bastion_ip" {
  type        = string
  description = "ip of bastion VM"
}
