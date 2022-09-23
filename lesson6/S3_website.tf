############  S3 static website ###############
resource "aws_s3_bucket" "s3website" {
  bucket        = "vult-website-${var.projectname}${var.lesson_number}"
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


resource "aws_s3_bucket_versioning" "s3website_versioning" {
  bucket = aws_s3_bucket.s3website.id
  versioning_configuration {
    status = "Disabled"
  }
}


resource "aws_s3_bucket_ownership_controls" "s3website_owner_control" {
  bucket = aws_s3_bucket.s3website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_acl" "s3website_acl" {
  bucket = aws_s3_bucket.s3website.id
  acl    = "public-read"
}


resource "aws_s3_bucket_request_payment_configuration" "s3website_payment" {
  bucket = aws_s3_bucket.s3website.bucket
  payer  = "BucketOwner"
}


resource "aws_s3_bucket_public_access_block" "s3websitepublicpolicy" {
  bucket                  = aws_s3_bucket.s3website.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}



data "aws_iam_policy_document" "s3websitepolicy" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.s3website.arn}/index.html",
      "${aws_s3_bucket.s3website.arn}/error.html",
      "${aws_s3_bucket.s3website.arn}/page1.html"
    ]
  }
}



resource "aws_s3_bucket_policy" "s3website_attach_policy" {
  bucket = aws_s3_bucket.s3website.id
  policy = data.aws_iam_policy_document.s3websitepolicy.json
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


resource "aws_s3_object" "upload_website_files" {
  for_each = fileset("./website/", "*")
  bucket   = aws_s3_bucket.s3website.bucket
  key      = each.value
  source   = "./website/${each.value}"
  etag     = filemd5("./website/${each.value}")
}
