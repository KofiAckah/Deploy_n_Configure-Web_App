# Simple Nginx Ansible Setup

Basic Ansible project to install and start Nginx on your EC2 instance.

## Quick Start

```bash
# 1. Test connection first
ansible-playbook test-playbook.yml

# 2. Install and start Nginx
ansible-playbook playbook.yml

# 3. Check if it's working
curl http://3.254.177.169
```

## Files Explained

- **playbook.yml** - Main playbook that installs and starts Nginx
- **test-playbook.yml** - Test playbook to check connection and server info
- **ansible.cfg** - Ansible configuration (SSH key location, etc.)
- **inventory/hosts** - Your server IP address (3.254.177.169)

## Why Two Playbooks?

- **test-playbook.yml** - Run this first to test if Ansible can connect to your server
- **playbook.yml** - Run this to actually install and start Nginx

## Next Steps

After Nginx is running, add your web application files to `/usr/share/nginx/html/` on the server.
