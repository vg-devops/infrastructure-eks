########################
### EKS Cluster Role ###
########################

resource "aws_iam_role" "eks_svc_role" {
  name               = "${var.project}-cluster-role"
  assume_role_policy = "TBC"
  tags               = local.common_tags

  lifecycle {
    ignore_changes = [
      tags["AutoTag_CreateTime"],
      tags["AutoTag_Creator"],
    ]
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_svc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  role       = aws_iam_role.eks_svc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}