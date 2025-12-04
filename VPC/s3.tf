
resource "aws_s3_bucket" "practicedemobucket0786" {
  bucket = "practicedemobucket0786"
  tags = {
    Name = "practicedemobucket0786"
  }
}

# 2. Configure Public Access Block (Security Defaults)
resource "aws_s3_bucket_public_access_block" "practicedemobucket0786" {
bucket = aws_s3_bucket.practicedemobucket0786.id

 # Set all to false to allow public ACLs and policies
 block_public_acls = false
 block_public_policy = false
 ignore_public_acls = false
 restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "practicedemobucket0786" {
 bucket = aws_s3_bucket.practicedemobucket0786.id
 rule {
  object_ownership = "BucketOwnerPreferred"
 }
}

# CORRECTED: Add the public access block dependency
resource "aws_s3_bucket_acl" "practicedemobucket0786" {
  depends_on = [
    aws_s3_bucket_ownership_controls.practicedemobucket0786,
    aws_s3_bucket_public_access_block.practicedemobucket0786 # <-- ADD THIS LINE
  ]

 bucket = aws_s3_bucket.practicedemobucket0786.id
 acl = "public-read" 
}

# Example of uploading an object and making it public-read
resource "aws_s3_object" "public_index_file" {
  bucket = aws_s3_bucket.practicedemobucket0786.id
  key    = "Terraform-Notes.txt"
  source = "../../Terraform-Notes.txt" # Change this path
  # CRITICAL: Set the ACL on the object itself
  acl    = "public-read" 
  content_type = "text/html"
}

output "demo_bucket_id" {
 value = aws_s3_bucket.practicedemobucket0786.id
}

output "demo_bucket_object_public_url" {
  value = "https://${aws_s3_bucket.practicedemobucket0786.bucket_domain_name}/${aws_s3_object.public_index_file.key}"
}