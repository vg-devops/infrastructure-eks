resource "aws_security_group" "eks_cluster" {
  name        = "${var.project}-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = data.terraform_remote_state.vpc_imports.outputs.vpc_id

  # inbound traffic from any VPC nodes
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [ data.terraform_remote_state.vpc_imports.outputs.vpc_cidr ]
  }

  # all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.project}-cluster-sg"
    }
  )
}