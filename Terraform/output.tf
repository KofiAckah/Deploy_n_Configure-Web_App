# Network Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = module.network.subnet_id
}

# Security Output
output "security_group_id" {
  description = "ID of the security group"
  value       = module.security.security_group_id
}

# Compute Outputs
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.compute.instance_public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = module.compute.instance_public_dns
}

output "web_url" {
  description = "URL to access the web application"
  value       = "http://${module.compute.instance_public_ip}"
}

output "private_key_path" {
  description = "Path to the SSH private key file for Ansible"
  value       = module.compute.private_key_path
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ${module.compute.private_key_path} ec2-user@${module.compute.instance_public_ip}"
}