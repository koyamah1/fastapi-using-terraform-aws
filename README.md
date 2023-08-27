```markdown
# FastAPI Deployment on AWS using Terraform

This repository contains code and configuration for deploying a FastAPI application on AWS using Terraform. The infrastructure includes an EC2 instance with a FastAPI application and an RDS database, all orchestrated using Terraform. Continuous integration and deployment (CI/CD) are set up using GitHub Actions.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Folder Structure](#folder-structure)
- [Terraform Modules](#terraform-modules)
- [GitHub Actions](#github-actions)
- [Customization](#customization)
- [Cleanup](#cleanup)
- [Contributing](#contributing)

## Introduction

This project demonstrates deploying a FastAPI application on Amazon Web Services (AWS) using Terraform. The infrastructure includes an EC2 instance to host the FastAPI application and an RDS database to store data. Security groups are configured to control inbound and outbound traffic.

## Features

- Deployment of a FastAPI application on an EC2 instance.
- Provisioning of an RDS database for data storage.
- Usage of security groups to control network traffic.
- Automated CI/CD setup using GitHub Actions.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- An AWS account with necessary permissions.
- AWS CLI installed and configured with your credentials.
- Terraform installed on your local machine.
- Git and GitHub account.

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/koyamah1/fastapi-using-terraform-aws.git
   ```

2. Navigate to the repository folder:

   ```bash
   cd fastapi-using-terraform-aws
   ```

3. Update the Terraform variables in the `terraform.tfvars` file to match your configuration.

4. Initialize Terraform:

   ```bash
   terraform init
   ```

5. Review the planned infrastructure changes:

   ```bash
   terraform plan
   ```

6. Apply the changes to create the infrastructure:

   ```bash
   terraform apply
   ```

7. Access the FastAPI application by opening the EC2 instance's public IP in a web browser.

## Folder Structure

The repository is organized as follows:

- `terraform/`: Contains the Terraform configuration files.
- `.github/workflows/`: Contains GitHub Actions workflow files.

## Terraform Modules

The Terraform code is organized into modules for better reusability and maintainability:

- `ec2-instance/`: Defines the EC2 instance resources.
- `rds-database/`: Defines the RDS database resources.

## GitHub Actions

Continuous integration and deployment (CI/CD) is set up using GitHub Actions. The workflow can be found in `.github/workflows/build.yml`.

## Customization

Feel free to customize this project according to your requirements. You can modify the FastAPI application, update Terraform variables, or add more AWS resources.

## Cleanup

To avoid incurring unnecessary AWS charges, remember to destroy the resources when they are no longer needed:

```bash
terraform destroy
```

## Contributing

Contributions to this project are welcome! If you find a bug or want to add a new feature, please open an issue or submit a pull request.
