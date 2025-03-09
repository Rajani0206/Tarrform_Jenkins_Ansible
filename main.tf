provider "aws" {
  
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default  = "ap-south-1"
}


module "EC2_Module" {
  source  = "github.com/Rajani0206/Terraform_Modules"
  vpc_cidr_block = var.vpc_cidr_block
  instance_type = var.instance_type
  ami_id= "ami-00bb6a80f01f03502"
  region = var.aws_region
  user_data = <<-EOF
              #!/bin/bash
              # Update the system
              sudo apt update -y

              # Install dependencies Ansible
              sudo apt install ansible -y

              # Install Terraform
              cd /tmp
              curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo tee /etc/apt/trusted.gpg.d/hashicorp.asc
              sudo apt-get update && sudo apt-get install terraform -y
            EOF


  tags = {
    Name = "TerraformAnsibleInstance"
  }

  
}
