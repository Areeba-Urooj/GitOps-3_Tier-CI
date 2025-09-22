output "cluster_id" {
  value = aws_eks_cluster.github-actions.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.github-actions.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.github-actions.name
}

output "node_group_id" {
  value = aws_eks_node_group.github-actions.id
}

output "vpc_id" {
  value = aws_vpc.Github_actions_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.github-actions_subnet[*].id
}