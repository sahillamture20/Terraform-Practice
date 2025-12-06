output "instance_hostname" {
  description = "Private DNS name of the EC2 instance."
  value       = aws_instance.demo_ins.private_dns
}

output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.demo_ins.id
}

# Output the security group ID for use in EC2 instances
output "security_group_id" {
  value = aws_security_group.web_server_sg.id
}

output "demo_bucket_object_public_url" {
  value = "https://${aws_s3_bucket.practicedemobucket0786.bucket_domain_name}/${aws_s3_object.public_index_file.key}"
}

# output the credentials of iam user
output "demo_iam_user_access_key" {
  value     = aws_iam_access_key.demo_iam_user_key.secret
  sensitive = true
}