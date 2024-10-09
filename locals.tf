locals {  
  common_tags = {
    "Project"     = var.project
    "Environment" = var.environment
    "Terraform"   = "true"
  }

  retention_in_days = var.environment == "development" ? 1 : 30
}

locals {
  ec2_subnets    = data.terraform_remote_state.vpc_imports.outputs.ec2_nodes_private_subnets
  fargate_subnets = data.terraform_remote_state.vpc_imports.outputs.fargate_nodes_private_subnets
  all_subnets     = concat(local.ec2_subnets, local.fargate_subnets)
}