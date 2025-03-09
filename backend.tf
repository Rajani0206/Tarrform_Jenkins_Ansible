terraform {
  backend s3{
    bucket = "jenkins-ansible-terraform"
    key = "remote.tfstate"
    region = "ap-south-1"
  }
}
