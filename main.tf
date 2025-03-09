provider "aws" {
    region = "ap-south-1"
  
}

module "EC2_Module" {
  source  = "github.com/Rajani0206/Terraform_Modules"
  vpc_cidr_block = var.vpc_cidr_block
  instance_type = var.instance_type
  environment = "${terraform.workspace}"
  ami_id= "ami-00bb6a80f01f03502"
  
}
