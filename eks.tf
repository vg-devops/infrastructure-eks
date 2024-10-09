resource "aws_eks_cluster" "control_plane" {
  name     = "${var.project}-cluster"

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller,
    aws_cloudwatch_log_group.eks_cw_control_log_group
  ]
  role_arn = aws_iam_role.eks_svc_role.arn

  vpc_config {
    subnet_ids = local.all_subnets
    security_group_ids = [aws_security_group.eks_cluster.id]
  }
  
}