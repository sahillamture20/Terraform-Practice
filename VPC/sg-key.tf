
# 1. Generate the Private/Public Key pair using the TLS provider
resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Upload the Public Key to AWS
resource "aws_key_pair" "demo_generated_key" {
  key_name   = "my-demo-key"
  public_key = tls_private_key.rsa_key.public_key_openssh
}

# 3. Save the Private Key locally (Highly sensitive!)
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_key.private_key_pem
  filename = "./my-demo-key.pem" # Path in your device
  # Set permissions to read-only for the owner
  file_permission = "0400"
}

# 4. Output the key name for use in EC2 instances 
output "demo_key_pair_name" {
  value = aws_key_pair.demo_generated_key.key_name
}


# Security Group
resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Allow SSH, ICMP, HTTP traffic"
  vpc_id      = aws_vpc.demo_vpc.id

  tags = {
    Name = "Web-Server-Security-Group"
  }

  # ----- Ingress [Inbound] rule -----
  # SSH
  ingress {
    description = "Allow SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # HTTP
  ingress {
    description = "Allow HTTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  #ICMP
  ingress {
    description = "Allow all ICMP traffic"
    from_port   = -1 # ICMP Type: -1 means all types
    to_port     = -1 # ICMP Code: -1 means all codes
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # --- Egress (Outbound) Rules ---
  # Terraform Security Groups require an explicit egress rule.
  # The default is to allow all outbound traffic.
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

}

