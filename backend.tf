terraform {
  required_version = ">= 0.13"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    /* aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    } */
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.11.0"
    }
  }
  backend "local" {
    path = "/Users/pamela.ty.shek/Desktop/example/terraform/state/terraform.tfstate"
  }
}
