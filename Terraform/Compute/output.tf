output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.web.private_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web.public_dns
}

output "private_key_path" {
  description = "Path to the private key file for SSH access"
  value       = local_file.private_key.filename
}

output "private_key_pem" {
  description = "Private key content in PEM format"
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}