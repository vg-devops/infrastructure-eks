resource "aws_eks_node_group" "main_eks_node_group" {
  cluster_name    = "${var.project}-cluster"
  node_group_name = "main"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = data.terraform_remote_state.vpc_imports.outputs.ec2_nodes_private_subnets

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_container_registry_policy,
  ]
}