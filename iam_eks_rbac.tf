data "kubernetes_config_map" "cm_for_aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
}

# Resource to manage the aws-auth ConfigMap
resource "kubernetes_config_map_v1_data" "cm_for_aws_auth_extras" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamlencode(concat(
      yamldecode(try(data.kubernetes_config_map.cm_for_aws_auth.data.mapUsers, "[]")),
      [
        {
          userarn  = data.terraform_remote_state.vpc_imports.outputs.ecr_user_arn
          username = "ecr-user"
          groups   = ["system:masters"]
        }
      ]
    ))
  }
}