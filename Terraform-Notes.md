In Terraform, the concept of a Directed Acyclic Graph (DAG) is fundamental to how it manages and applies infrastructure changes. 
Here's how DAGs relate to Terraform: 

• Dependency Graph: Terraform builds an internal dependency graph of your infrastructure. This graph represents each resource as a node and the relationships between them (e.g., one resource needing another's output) as directed edges. The "acyclic" part means there are no circular dependencies, which would lead to an infinite loop in provisioning. 
• Order of Operations: This dependency graph dictates the order in which Terraform provisions, modifies, or destroys resources. Resources with no dependencies can be created first, and those with dependencies are created only after their prerequisites are met. This ensures that infrastructure is built in a logical and consistent manner. 
• Parallel Execution: The DAG also allows Terraform to identify resources that are independent of each other and can be provisioned in parallel, significantly speeding up the terraform apply process. 
• Handling Implicit and Explicit Dependencies: 
	• Implicit Dependencies: Terraform automatically infers many dependencies by analyzing resource attributes and interpolations. For example, if a aws_instance resource uses the aws_vpc's ID, Terraform understands that the VPC must exist before the instance can be created. 
	• Explicit Dependencies: In cases where Terraform cannot automatically detect a dependency (e.g., when a resource needs to be created before another for a reason not directly tied to attribute references), you can explicitly define it using the depends_on argument. 

In essence, the DAG is the blueprint Terraform uses to understand the relationships within your infrastructure and orchestrate the necessary actions to bring it to the desired state. 

=================================

Terraform Commands :

terraform init
terraform plan
terraform fmt
terraform validate
terraform apply
terraform apply -auto-approve
terraform destroy
terraform destroy -target=resource_type.resource_name
terraform plan -out <file-path-name>.tfplan
	Example: terraform plan -out my_infra_plan.tfplan
	Note: The file created with "terraform plan -out=..." is not directly human-readable. 
	      It is saved in a binary format intended only to be consumed by the terraform apply command.
terraform show <file-pat-name>.tfplan
	Example: terraform show my_infra_plan.tfplan
	Note: Reads and outputs a Terraform state or plan file in a human-readable
  		  form. If no path is specified, the current state will be shown.
	Options:
		-no-color   If specified, output won't contain any color.
			Example: terraform show -no-color my_infra_plan.tfplan > readable_plan.txt
  		-json       If specified, output the Terraform plan or state in a machine-readable form.
			Example: terraform show -json my_infra_plan.tfplan
	