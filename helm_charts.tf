resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/component"  = "controller"
      "app.kubernetes.io/managed-by" = "Helm"
    }
    annotations = {
      "eks.amazonaws.com/role-arn"               = aws_iam_role.aws_load_balancer_controller.arn
      "meta.helm.sh/release-name"                = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace"           = "kube-system"
    }
  }

  lifecycle {
    ignore_changes = all
  }
  depends_on = [data.aws_eks_cluster.cluster]
}

# resource "helm_release" "aws-load-balancer-controller" {
#   name = "aws-load-balancer-controller"

#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"
#   namespace  = "kube-system"
#   version    = "1.9.0"

#   set {
#     name  = "clusterName"
#     value = aws_eks_cluster.control_plane.id
#   }

#   set {
#     name  = "image.tag"
#     value = "v2.9.0"
#   }

#   set {
#     name  = "region"
#     value = "eu-west-2"
#   }

#   set {
#     name  = "vpcId"
#     value = data.terraform_remote_state.vpc_imports.outputs.vpc_id
#   }

#   set {
#     name  = "serviceAccount.name"
#     value = "aws-load-balancer-controller"
#   }

#   set {
#     name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = aws_iam_role.aws_load_balancer_controller.arn
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.aws_load_balancer_controller_attach,
#     kubernetes_service_account.aws_load_balancer_controller
#   ]
# }