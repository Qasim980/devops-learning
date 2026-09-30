# 07 - Terraform

Infrastructure as Code (IaC) – define your infrastructure in code, version it, and automate deployments.

## What You'll Learn

- Terraform basics and HCL syntax
- Providers and resources
- Variables and outputs
- State management
- Modules for reusability
- Workspaces for environments
- Best practices

## Folder Structure

```
07-terraform/
├── notes/       # Your notes from lessons
├── labs/        # Completed lab exercises
└── projects/    # Hands-on projects
```

## Suggested Projects

- [ ] Deploy a VPC with Terraform
- [ ] Create an EC2 instance with security groups
- [ ] Build a reusable module
- [ ] Set up remote state with S3 backend
- [ ] Multi-environment setup (dev/staging/prod)

## Key Commands

```bash
terraform init      # Initialise working directory
terraform plan      # Preview changes
terraform apply     # Apply changes
terraform destroy   # Destroy infrastructure
terraform fmt       # Format code
terraform validate  # Validate configuration
terraform state list # List resources in state
```

## Basic Structure

```hcl
# provider.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# variables.tf
variable "region" {
  default = "eu-west-2"
}

# main.tf
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  
  tags = {
    Name = "web-server"
  }
}

# outputs.tf
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

## Best Practices

- Use remote state (S3 + DynamoDB for locking)
- Never commit `.tfstate` files
- Use variables for anything environment-specific
- Create modules for reusable components
- Use `terraform fmt` before committing
- Pin provider versions

## Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
