data "aws_eks_cluster" "cluster" {
  name = "${var.project}-cluster"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "${var.project}-cluster"
}