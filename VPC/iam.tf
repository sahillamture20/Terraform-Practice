
# Create the IAM User (aws_iam_user)
resource "aws_iam_user" "demo_iam_user" {
  name          = "demo-ec2-s3-full-access-user"
  force_destroy = true
}

# Attach the Policies (aws_iam_user_policy_attachment)

#Full EC2 Access
resource "aws_iam_user_policy_attachment" "demo_iam_user_ec2_policy" {
  user       = aws_iam_user.demo_iam_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

#Full S3 Access
resource "aws_iam_user_policy_attachment" "demo_iam_user_s3_policy" {
  user       = aws_iam_user.demo_iam_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Create the Access Key (aws_iam_access_key) 
resource "aws_iam_access_key" "demo_iam_user_key" {
  user = aws_iam_user.demo_iam_user.name
  # Setting this to true means the key will be immediately active
  # retrieve them directly from the state file or the output block
  status = "Active"
}


