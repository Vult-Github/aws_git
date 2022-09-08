terraform {
  required_version = ">= 1.2.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket  = "vult-lessons-core-s3"
    key     = "lesson1/lesson1.tfstate"
    region  = "us-east-1"
    profile = "lessonvult"
  }
}

provider "aws" {
  profile = "lessonvult"
  region  = "us-east-1"
}
