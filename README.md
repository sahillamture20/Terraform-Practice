# Terraform AWS Infrastructure Project

This is a comprehensive Terraform project demonstrating Infrastructure as Code (IaC) principles by provisioning and managing AWS resources including VPC networking, S3 storage, IAM security, and EC2 compute instances.

## 📋 Overview

This project showcases best practices in infrastructure automation by:
- Defining AWS resources declaratively using Terraform
- Organizing infrastructure code into modular `.tf` files for maintainability
- Managing multiple AWS services in a cohesive, scalable environment

### Project Structure

The infrastructure is organized into separate Terraform files for clarity:
- `vpc.tf` - Virtual Private Cloud networking configuration
- `iam.tf` - Identity and Access Management policies and roles
- `s3.tf` - S3 bucket storage resources
- `instance.tf` - EC2 compute instances
- `sg-key.tf` - Security groups and SSH key pairs

This modular approach makes the codebase maintainable, scalable, and easy to understand.

## 🔧 Prerequisites

Before you begin, ensure you have the following installed and configured:

- **AWS Account** - Active AWS account with appropriate permissions
- **Terraform CLI** - [Download Terraform](https://www.terraform.io/downloads)
- **AWS CLI** - [Install AWS CLI](https://aws.amazon.com/cli/) and configure credentials

## 🚀 Setup & Deployment

### 1. Clone the Repository
```bash
git clone https://github.com/sahillamture20/Terraform-Practice.git
cd Terraform-Practice
```

### 2. Initialize Terraform
```bash
terraform init
```
This downloads required provider plugins and initializes the working directory.

### 3. Review Infrastructure Plan
```bash
terraform plan
```
Preview the resources that will be created/modified without making actual changes.

### 4. Apply Configuration
```bash
terraform apply
```
Deploy the infrastructure to AWS. Type `yes` when prompted to confirm.

### 5. Destroy Infrastructure (Optional)
```bash
terraform destroy
```
Remove all resources created by this project when no longer needed.

## 🔮 Future Enhancements

### Immediate Upgrades (Intermediate Level)

#### 1. Variables and Outputs
- **Add `variables.tf`** - Centralize configuration values - Impletemented on 07 Dec 2025
- **Add `outputs.tf`** - Export important resource attributes - Impletemented on 07 Dec 2025
- **Use Variable References** - Replace hardcoded values with `var.` references - Impletemented on 07 Dec 2025
- **Save plan** - Save your infrastructure plan with "terraform plan -out" - - Impletemented on 07 Dec 2025

#### 2. Data Sources
- Fetch existing AWS resources dynamically
- Reference AMIs, availability zones, and account information

#### 3. Resource Dependencies
- Implement `depends_on` for explicit ordering
- Add `lifecycle` rules to ignore specific changes

#### 4. S3 Enhancements
- Enable versioning for object history
- Add server-side encryption (SSE-KMS)
- Configure lifecycle policies for cost optimization

### Advanced Features (Production-Ready)

#### 1. Modularization
Convert files into reusable modules:
```
modules/
├── vpc/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── iam/
├── s3/
└── compute/
```
Reference modules: `module "vpc" { source = "./modules/vpc" }`

#### 2. Remote State Management
- **Backend Configuration** - Store state in S3 bucket
- **State Locking** - Use DynamoDB for concurrent access protection
- **State Encryption** - Enable encryption at rest

#### 3. Advanced AWS Resources

**Compute & Networking:**
- Auto Scaling Group (ASG) for dynamic scaling
- Application Load Balancer (ALB) for traffic distribution
- NAT Gateway for private subnet internet access
- Multi-AZ deployment for high availability

**Database:**
- RDS instance (MySQL/PostgreSQL) in private subnet
- DB security groups with restrictive ingress rules
- Automated backups and monitoring

**Additional Services:**
- CloudWatch logging and alarms
- SNS notifications for infrastructure events
- Secrets Manager for sensitive data

#### 4. CI/CD Integration
- **GitHub Actions/Jenkins** - Automated `terraform plan` on pull requests
- **Pre-commit Hooks** - Validate and format code before commits

## 📚 Learning Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 👤 Author

**Sahil Lamture**
- GitHub: [@sahillamture20](https://github.com/sahillamture20)

---

⭐ If you find this project helpful, please consider giving it a star!
