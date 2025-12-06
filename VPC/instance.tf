
resource "aws_instance" "demo_ins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.demo_public_sub.id
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  key_name               = aws_key_pair.demo_generated_key.key_name
  availability_zone      = var.availability_zone[0]
  tags = {
    Name        = var.instance_tags["Name"]
    Environment = var.instance_tags["Environment"]
    Project     = var.instance_tags["Project"]
  }
  user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<h1>Hello from Terraform EC2</h1>" > /var/www/html/index.html
    EOF

}