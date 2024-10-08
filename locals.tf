locals {  
  common_tags = {
    "Project"     = var.project
    "Environment" = var.environment
    "Terraform"   = "true"
  }

  retention_in_days = var.environment == "development" ? 1 : 30
}