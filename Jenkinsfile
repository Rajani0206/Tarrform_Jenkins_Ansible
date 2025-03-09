pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('access_key')
        AWS_SECRET_ACCESS_KEY = credentials('secret_key')
        AWS_REGION = 'ap-south-1'         // Specify your AWS region
        TF_STATE_BUCKET = 'jenkins-ansible-terra'   // S3 bucket to store Terraform state
        TF_BACKEND_CONFIG = 'backend.tfvars'  // A file with S3 backend configuration if required
        
   }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout your repository containing Terraform code and Ansible playbooks
                git branch: 'main', url: 'https://github.com/Rajani0206/Tarrform_Jenkins_Ansible.git'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    echo "Using AWS Access Key ID: ${AWS_ACCESS_KEY_ID}"
                    echo "Using AWS Secret Access Key: ${AWS_SECRET_ACCESS_KEY}"
                    sh """
                    terraform init -backend-config=bucket=${TF_STATE_BUCKET} -backend-config=key=terraform.tfstate -backend-config=region=${AWS_REGION}
                    """
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh "terraform plan -var 'aws_region=${AWS_REGION}'"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Terraform apply to provision EC2 instance
                    sh "terraform apply -auto-approve -var 'aws_region=${AWS_REGION}'"
                }
            }
        }

        stage('Configure EC2 with Ansible') {
            steps {
                script {
                    // Assume Terraform output gives the EC2 instance public IP or DNS
                    def ec2_public_ip = sh(script: "terraform output -raw instance_public_ip", returnStdout: true).trim()

                    // Set up Ansible inventory with the EC2 instance IP
                    writeFile file: 'inventory.ini', text: """
                    [ec2_instance]
                    ${ec2_public_ip}
                    """

                    // Run the Ansible playbook to configure the EC2 instance
                    sh """
                    ansible-playbook -i inventory.ini tomcat_install.yml
                    """
                }
            }
        }
    }

    
}
