resource "aws_eks_fargate_profile" "eks_fargate_general" {
  cluster_name           = aws_eks_cluster.control_plane.name
  fargate_profile_name   = "${var.project}-fargate-profile"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = data.terraform_remote_state.vpc_imports.outputs.fargate_nodes_private_subnets

  selector {
    namespace = "fargate-ns"
    labels = {
      "fargate" = "true"
    }
  }

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.project}-fargate-profile"
    }
  )
}

