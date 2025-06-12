# EKS SG

resource "aws_security_group_rule" "allow_ingress" {
  depends_on        = [aws_security_group.worker_nodes_sg]
  security_group_id = aws_security_group.k8scluster-sg.id

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.worker_nodes_sg.id

}

resource "aws_security_group_rule" "allow_egress_443" {
  depends_on        = [aws_security_group.worker_nodes_sg]
  security_group_id = aws_security_group.k8scluster-sg.id

  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.worker_nodes_sg.id
}

resource "aws_security_group_rule" "allow_egress_tcp" {
  depends_on        = [aws_security_group.worker_nodes_sg]
  security_group_id = aws_security_group.k8scluster-sg.id

  type                     = "egress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.worker_nodes_sg.id
}

# Worker nodes SG

# resource "aws_security_group" "worker_nodes_sg" {
#   name        = "worker-nodes-sg"
#   description = "Security Group for EKS Worker Nodes"
#   vpc_id      = var.vpc_id
#   dynamic "ingress" {
#     for_each = [22, 80, 443]

#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   ingress {
#     from_port = 0
#     to_port   = 0
#     protocol  = -1
#     self      = true
#   }

#   ingress {
#     from_port       = 1025
#     to_port         = 65535
#     protocol        = "tcp"
#     security_groups = [aws_security_group.k8scluster-sg.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     "kubernetes.io/cluster/${local.cluster_name}" = "owned"
#     "Name"                                        = "eks-workernodes-sg-${local.cluster_name}"
#   }

# }
