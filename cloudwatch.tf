########################
### EKS CW Log group ###
########################

resource "aws_cloudwatch_log_group" "eks_cw_control_log_group" {
  name              = "/aws/eks/exa_assessment/cluster"
  retention_in_days = "TBC"

  lifecycle {
    ignore_changes = [
      tags["AutoTag_CreateTime"],
      tags["AutoTag_Creator"],
    ]
  }
}