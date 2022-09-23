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

variable "subnet_privateA_cidr" {
  type        = string
  description = "CIDR for subnet A private"
}

variable "subnet_privateB_cidr" {
  type        = string
  description = "CIDR for subnet B private"
}

variable "subnet_availib_zone" {
  type        = string
  description = "Availability zone for subnets"
}

variable "subnet_privateA_zone" {
  type        = string
  description = "Availability zone for DB A"
}

variable "subnet_privateB_zone" {
  type        = string
  description = "Availability zone for DB B"
}

variable "db_admin_name" {
  type        = string
  description = "User for mariaDB"
}

variable "db_admin_pass" {
  type        = string
  description = "Pass for mariaDB"
}

variable "db_port" {
  type        = string
  description = "Port for mariaDB"
}
