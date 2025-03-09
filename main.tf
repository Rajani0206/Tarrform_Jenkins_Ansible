provider "aws" {
    region = var.aws_region
  
}

module "EC2_Module" {
  source  = "github.com/Rajani0206/Terraform_Modules"
  vpc_cidr_block = var.vpc_cidr_block
  instance_type = var.instance_type
  ami_id= "ami-00bb6a80f01f03502"
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
