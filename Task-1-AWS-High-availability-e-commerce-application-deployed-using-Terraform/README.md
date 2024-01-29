# terraform-projects
**
#### **Deploy** Infrastructure as Code using Terraform   [project link ](/terraform-deploy-high-availability-web)
####  Deploy Infrastructure as Code we will deploy a dummy  web store application (This is a sample e-commerce application built for learning purposes.) to the Apache Web Server running on an EC2 instance. [e-commerce application ](https://github.com/kodekloudhub/learning-app-ecommerce)
 <img src="https://github.com/udacity/nd9991-c2-Infrastructure-as-Code-v1/blob/master/supporting_material/AWSWebApp.jpeg" alt="Permissions" align="right" />
 

Here is a sample `README.md` file for a project on AWS with Terraform:

# Project Title

## Overview

This project involves deploying a web application architecture on AWS using Terraform. The architecture is designed to be highly available and scalable, ensuring optimal performance and reliability.

## Architecture Components

- **VPC (Virtual Private Cloud)**: Customized virtual network, enhancing the security and scalability of the application.
- **Public Subnets**: Hosts the Elastic Load Balancer and NAT Gateways ensuring high availability and internet accessibility.
- **Private Subnets**: Contains the auto-scaling EC2 instances running the web applications, isolated for enhanced security.
- **Auto-Scaling**: Automatically adjusts the number of EC2 instances, ensuring that the application scales to meet demand.
- **Elastic Load Balancer**: Distributes incoming traffic across multiple targets, such as EC2 instances in different Availability Zones.
- **MySQL DB**: A primary and secondary MySQL database setup for data storage, retrieval, and management.

## Deployment Steps Using Terraform

1. Clone this repository to your local machine.
2. Navigate to the project directory containing Terraform files (.tf).
3. Initialize your Terraform workspace with `terraform init`, which will download provider plugins.
4. Apply your configuration with `terraform apply`. This command will provide an execution plan and prompt you for approval before proceeding.

## Prerequisites

Ensure you have installed:
- AWS CLI 
- Terraform

Note: Update variables.tf file with your AWS credentials or ensure your AWS CLI is configured properly.

## Contributing

If you'd like to contribute to this project, please fork the repository and submit a pull request with your proposed changes.

## License

This project is licensed under the MIT License - see the LICENSE file for details.



