# Terraform Notes

## Table of Contents
- [Core Concepts](#core-concepts)
- [Essential Commands](#essential-commands)
- [Advanced Commands](#advanced-commands)
- [Best Practices](#best-practices)

---

## Core Concepts

### Directed Acyclic Graph (DAG)

The DAG is fundamental to how Terraform manages and applies infrastructure changes. Understanding this concept is crucial for efficient infrastructure provisioning.

#### What is a DAG in Terraform?

**Dependency Graph**
- Terraform builds an internal dependency graph of your infrastructure
- Each resource is represented as a **node**
- Relationships between resources (e.g., one resource requiring another's output) are **directed edges**
- The **acyclic** nature means no circular dependencies exist, preventing infinite provisioning loops

#### How Terraform Uses the DAG

**1. Order of Operations**
- The dependency graph dictates the sequence for provisioning, modifying, or destroying resources
- Resources with no dependencies are created first
- Dependent resources are created only after their prerequisites are satisfied
- Ensures logical and consistent infrastructure deployment

**2. Parallel Execution**
- The DAG identifies independent resources that can be provisioned simultaneously
- Significantly speeds up the `terraform apply` process
- Maximizes efficiency by leveraging parallelism where possible

**3. Dependency Management**

**Implicit Dependencies** (Automatic)
- Terraform automatically infers dependencies by analyzing resource attributes and interpolations
- Example: If an `aws_instance` references an `aws_vpc` ID, Terraform understands the VPC must exist first
```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  vpc_id        = aws_vpc.main.id  # Implicit dependency
}
```

**Explicit Dependencies** (Manual)
- Used when Terraform cannot automatically detect a dependency
- Define using the `depends_on` argument
- Necessary when creation order matters but isn't tied to attribute references
```hcl
resource "aws_iam_role" "example" {
  name = "example-role"
  # ... configuration
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  depends_on = [aws_iam_role.example]  # Explicit dependency
}
```

#### Visualizing the DAG

You can visualize your infrastructure's dependency graph:
```bash
terraform graph | dot -Tpng > graph.png
```
*Requires Graphviz to be installed*

---

## Essential Commands

### Initialization and Setup

#### `terraform init`
Initializes a Terraform working directory
- Downloads required provider plugins
- Sets up backend configuration
- Initializes modules
```bash
terraform init
```

---

### Code Quality and Validation

#### `terraform fmt`
Formats Terraform configuration files to canonical style
```bash
terraform fmt
```

#### `terraform validate`
Validates the configuration syntax and internal consistency
```bash
terraform validate
```

**What it checks:**
- Syntax errors
- Invalid resource/variable references
- Type mismatches
- Required arguments

**Note:** Does NOT check for provider-specific logic or API connectivity

---

### Planning and Applying Changes

#### `terraform plan`
Creates an execution plan showing what actions Terraform will take
```bash
terraform plan
```

**Common Options:**
```bash
terraform plan -out=plan.tfplan              # Save plan to file
terraform plan -var="instance_type=t2.large" # Override variable
terraform plan -target=aws_instance.web      # Plan for specific resource
terraform plan -refresh=false                # Skip state refresh
```

#### `terraform plan -out <filename>.tfplan`
Saves the execution plan to a binary file for later application
```bash
terraform plan -out=my_infra_plan.tfplan
```

**Important Notes:**
- The generated `.tfplan` file is in **binary format**
- NOT directly human-readable
- Intended only for consumption by `terraform apply`
- Should be added to `.gitignore` (may contain sensitive data)

**Recommended Workflow:**
```bash
# 1. Generate plan
terraform plan -out=production.tfplan

# 2. Review plan (human-readable)
terraform show production.tfplan

# 3. Apply the exact plan
terraform apply production.tfplan

# 4. Clean up
rm production.tfplan
```

---

#### `terraform show <filename>.tfplan`
Displays a Terraform state or plan file in human-readable format
```bash
terraform show my_infra_plan.tfplan
```

**Behavior:**
- If no path specified, shows the current state
- Reads binary `.tfplan` files and outputs readable text
- Useful for reviewing saved plans before applying

**Options:**

**No Color Output:**
```bash
terraform show -no-color my_infra_plan.tfplan
```

**Save to Text File:**
```bash
terraform show -no-color my_infra_plan.tfplan > readable_plan.txt
```

**JSON Output (Machine-Readable):**
```bash
terraform show -json my_infra_plan.tfplan
terraform show -json my_infra_plan.tfplan | jq '.' > plan.json
```

**Show Current State:**
```bash
terraform show                    # Human-readable state
terraform show -json              # JSON state output
```

---

#### `terraform apply`
Applies the changes required to reach the desired infrastructure state
```bash
terraform apply
```

**Common Options:**
```bash
terraform apply -auto-approve               # Skip interactive approval
terraform apply my_infra_plan.tfplan        # Apply saved plan
terraform apply -var="region=us-west-2"     # Override variable
terraform apply -target=aws_instance.web    # Apply specific resource
```

**Best Practice:** Always run `terraform plan` before `terraform apply`

---

### Destroying Infrastructure

#### `terraform destroy`
Destroys all resources managed by Terraform
```bash
terraform destroy
```

**Options:**
```bash
terraform destroy -auto-approve                      # Skip confirmation
terraform destroy -target=aws_instance.web           # Destroy specific resource
terraform destroy -var="environment=staging"         # With variable override
```

**Warning:** Use carefully in production—may break dependent resources

---

### Output and Import

#### `terraform output`
Displays output values from state file
```bash
terraform output                    # Show all outputs
terraform output instance_ip        # Show specific output
terraform output -json              # JSON format
```

---

## Best Practices

### Development Workflow

1. **Initialize Project**
   ```bash
   terraform init
   ```

2. **Format Code**
   ```bash
   terraform fmt -recursive
   ```

3. **Validate Configuration**
   ```bash
   terraform validate
   ```

4. **Plan Changes**
   ```bash
   terraform plan -out=changes.tfplan
   ```

5. **Review Plan**
   ```bash
   terraform show changes.tfplan
   ```

6. **Apply Changes**
   ```bash
   terraform apply changes.tfplan
   ```

7. **Clean Up Plan File**
   ```bash
   rm changes.tfplan
   ```

---

### Security Best Practices

✅ **DO:**
- Use variables for sensitive values
- Store state remotely (S3, Terraform Cloud)
- Enable state encryption
- Use `.tfvars` files for environment-specific values
- Add `.tfplan` and `.tfstate` to `.gitignore`
- Use least-privilege IAM policies
- Enable MFA for state backend access

❌ **DON'T:**
- Hardcode credentials in `.tf` files
- Commit `.tfstate` or `.tfplan` files to version control
- Share `.tfvars` files containing secrets
- Use default VPC or security groups in production
- Apply changes without reviewing plan first

---

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [HashiCorp Learn](https://learn.hashicorp.com/terraform)

---

**Last Updated:** December 2025