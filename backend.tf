provider "aws" {
  region  = var.region
}

provider "kubernetes" {
  host                   = aws_eks_cluster.control_plane.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.control_plane.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

## as stated at https://registry.terraform.io/providers/hashicorp/helm/latest/docs
provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.control_plane.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.control_plane.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }  
}

terraform {
  #This is set to a major version, so changes beyond 1.9 cannot be used when untested.
  required_version = "~> v1.9.7"

  backend "s3" {
    bucket = "terraform-states-361769587713" # -{ACCOUNT_ID_PLACEHOLDER}
    key    = "network/development_environment_eks.tfstate"
    region = "eu-west-2"
    
    # role_arn     = "arn:aws:iam::{ACCOUNT_ID_PLACEHOLDER}:role/terraform"
    # session_name = "terraform"
  }
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.70.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
    helm       = {
      source  = "hashicorp/helm"
      version = "~> 2.15.0"
    }

    tls       = {
      source  = "hashicorp/tls"
      version = "~> 4.0.6"
    }

  }
}