terraform {
  required_version = "~>1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
   backend "s3" {
    bucket = "global-jenkins"
    region = "eu-west-2"
    key    = "global/jenkins/terraform.tfstate"
  }

}

provider "aws" {
  region = var.region
  default_tags {

    tags = {
      BillingID = "Platform"
      Project   = "Jenkins"
      terraform = true
    }
  }
  
}