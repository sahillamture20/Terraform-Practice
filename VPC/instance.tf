
resource "aws_instance" "demo_ins" {
    ami           = "ami-0d176f79571d18a8f"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.demo_public_sub.id
    vpc_security_group_ids = [aws_security_group.web_server_sg.id]
    key_name = aws_key_pair.demo_generated_key.key_name
    availability_zone = "ap-south-1a"
    tags = {
        Name = "demo_ins"
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