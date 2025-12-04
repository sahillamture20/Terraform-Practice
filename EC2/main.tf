provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d176f79571d18a8f"
  instance_type = "t2.micro"
  tags = {
    "Name" : "Terraform-Instance"
  }
  key_name = "ins-key-4"

}