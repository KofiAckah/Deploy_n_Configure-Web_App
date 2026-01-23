# Network Module - VPC, Subnet, IGW, Route Table
module "network" {
  source = "./Network"

  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  project_name      = var.project_name
}

# Security Module - Security Group
module "security" {
  source = "./Security"

  vpc_id       = module.network.vpc_id
  project_name = var.project_name
}

# Compute Module - EC2 Instance
module "compute" {
  source = "./Compute"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.network.subnet_id
  security_group_id = module.security.security_group_id
  key_name          = var.key_name
  project_name      = var.project_name
}

# Generate Ansible Inventory File Automatically
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    instance_ip         = module.compute.instance_public_ip
    ansible_user        = "ec2-user"
    private_key_path    = module.compute.private_key_path
    python_interpreter  = "/usr/bin/python3"
  })
  filename = "${path.module}/../Ansible/inventory.ini"
}