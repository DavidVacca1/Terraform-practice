resource "aws_launch_template" "k8scluster_nodegroup_lt" {
  depends_on  = [aws_security_group.worker_nodes_sg]
  name        = "${local.cluster_name}-nodegroup-lt"
  description = "Amazon EKS self-managed nodes"

  instance_type = var.instance_type
  image_id      = data.aws_ami.selected_eks_optimized_ami.id
  ebs_optimized = data.aws_ec2_instance_type.selected.ebs_optimized_support == "default" ? true : false
  key_name      = "ssh_key"

  vpc_security_group_ids = [aws_security_group.worker_nodes_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.k8scluster_nodegroup_instance_profile.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = var.volume_type
    }
  }

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    cluster_name = "${local.cluster_name}"
  }))

  tags = {
    Name = "${local.cluster_name}-launch-template"
  }
}



resource "aws_autoscaling_group" "k8scluster_nodegroup_asg" {
  name = "${local.cluster_name}-nodegroup_asg"

  desired_capacity = var.workers_desired
  max_size         = var.workers_max
  min_size         = var.workers_min

  vpc_zone_identifier = var.Public_subnets

  health_check_type = var.health_check_type
  force_delete      = true
  tag {
    key                 = "Name"
    value               = "${local.cluster_name}-auto-scaling-group"
    propagate_at_launch = true
  }
  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.k8scluster_nodegroup_lt.id
        version            = "$Latest"
      }
    }
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 20
      spot_allocation_strategy                 = "lowest-price"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_policies
  ]
}
