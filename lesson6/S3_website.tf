############  S3 static website ###############
resource "aws_s3_bucket" "s3website" {
  bucket        = "s3-website-vult-${var.projectname}${var.lesson_number}"
  description   = "S3 for static website"
  force_destroy = "true"
  tags = {
    Name        = "S3-website-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "S3"
    Description = "S3 for website"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}



resource "aws_s3_bucket_acl" "s3website_acl" {
  bucket = aws_s3_bucket.s3website.id
  acl    = "public-read"
}



resource "aws_s3_bucket_versioning" "s3website_versioning" {
  bucket = aws_s3_bucket.s3website.id
  versioning_configuration {
    status = "Disabled"
  }
}



resource "aws_s3_bucket_request_payment_configuration" "s3website_payment" {
  bucket = aws_s3_bucket.s3website.bucket
  payer  = "BucketOwner"
}



resource "aws_s3_bucket_website_configuration" "s3website_conf" {
  bucket = aws_s3_bucket.s3website.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}



resource "aws_s3_bucket_public_access_block" "s3websitepublicpolicy" {
  bucket = aws_s3_bucket.s3website.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



data "aws_iam_policy_document" "s3websitepolicy" {
policy
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "${aws_s3_bucket.s3website.arn}/index.html"
                "${aws_s3_bucket.s3website.arn}/error.html"
            ]
        }
    ]
}


}



resource "aws_s3_bucket_policy" "s3website_attach_policy" {
  bucket = aws_s3_bucket.s3website.id
  policy = data.aws_iam_policy_document.s3website_conf.json
}
