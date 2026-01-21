# Todo App Deployment with Ansible

Complete Ansible automation to deploy a Node.js Todo application with MongoDB and Nginx on AWS EC2.

## What This Does

This playbook automatically:
- ✅ Installs and configures MongoDB 7.0
- ✅ Installs Node.js 20.x and npm
- ✅ Clones your Todo app from GitHub
- ✅ Installs npm dependencies
- ✅ Creates systemd service for the app
- ✅ Configures Nginx as reverse proxy
- ✅ Sets up health checks and monitoring

## Quick Start

```bash
# 1. Test connection to server
ansible-playbook test-playbook.yml

# 2. Deploy the full application
ansible-playbook site.yml

# 3. Access your app
curl http://YOUR_EC2_PUBLIC_IP
```

## Files Structure

```
Ansible/
├── ansible.cfg          # Ansible configuration
├── inventory.ini        # Server inventory (EC2 IP address)
├── site.yml            # Main deployment playbook
├── test-playbook.yml   # Connection test playbook
└── README.md           # This file
```

## Prerequisites

- AWS EC2 instance (Amazon Linux 2023) deployed via Terraform
- SSH key pair generated and configured
- Security group allowing ports: 22 (SSH), 80 (HTTP), 443 (HTTPS)
- Ansible installed on your local machine

## Deployment Details

### Application Stack

- **Frontend**: EJS templates with responsive CSS
- **Backend**: Node.js + Express.js
- **Database**: MongoDB 7.0
- **Web Server**: Nginx (reverse proxy)
- **Port**: App runs on 3000, Nginx proxies to port 80

### GitHub Repository

- **Repo**: https://github.com/KofiAckah/Deploy_n_Configure-Web_App.git
- **Branch**: main
- **App Location**: `/var/www/todoapp/webapp`

### Services Created

1. **mongod.service** - MongoDB database
2. **todoapp.service** - Node.js application
3. **nginx.service** - Web server and reverse proxy

## Usage

### Deploy Application

```bash
ansible-playbook site.yml
```

### Test Connection Only

```bash
ansible-playbook test-playbook.yml
```

### Check Application Status

```bash
# SSH into server
ssh -i ../Terraform/Compute/AnsibleKeyPair.pem ec2-user@YOUR_EC2_IP

# Check services
sudo systemctl status todoapp
sudo systemctl status mongod
sudo systemctl status nginx

# View application logs
sudo journalctl -u todoapp -f

# Check MongoDB
sudo systemctl status mongod
mongosh
```

### Access Points

- **Main App**: http://YOUR_EC2_PUBLIC_IP
- **Health Check**: http://YOUR_EC2_PUBLIC_IP/health
- **Direct App**: http://YOUR_EC2_PUBLIC_IP:3000 (if security group allows)

## Configuration

### Environment Variables

The playbook creates `/var/www/todoapp/webapp/.env`:

```env
PORT=3000
MONGDB_URI=mongodb://localhost:27017/todoapp
NODE_ENV=production
```

### Nginx Configuration

Reverse proxy configuration at `/etc/nginx/conf.d/todoapp.conf`:
- Proxies requests from port 80 to Node.js app on port 3000
- Handles WebSocket upgrades
- Forwards real IP and headers

## Troubleshooting

### App Not Starting

```bash
# Check service status
sudo systemctl status todoapp

# View detailed logs
sudo journalctl -u todoapp -n 50

# Restart service
sudo systemctl restart todoapp
```

### MongoDB Issues

```bash
# Check MongoDB status
sudo systemctl status mongod

# View MongoDB logs
sudo journalctl -u mongod -n 50

# Restart MongoDB
sudo systemctl restart mongod
```

### Nginx Issues

```bash
# Test configuration
sudo nginx -t

# Check status
sudo systemctl status nginx

# View error logs
sudo tail -f /var/log/nginx/error.log
```

### Re-deploy Application

```bash
# Run playbook again (will pull latest from GitHub)
ansible-playbook site.yml

# Or manually on server
ssh ec2-user@YOUR_EC2_IP
cd /var/www/todoapp
sudo git pull origin main
cd webapp
sudo npm install
sudo systemctl restart todoapp
```

## Customization

### Change GitHub Repository

Edit [site.yml](site.yml) variables section:

```yaml
vars:
  github_repo: "https://github.com/YOUR_USERNAME/YOUR_REPO.git"
```

### Change Application Port

Edit [site.yml](site.yml) variables:

```yaml
vars:
  app_port: 3000  # Change to your desired port
```

### Add More Servers

Edit [inventory.ini](inventory.ini):

```ini
[webservers]
server1 ansible_host=3.254.177.169 ansible_user=ec2-user
server2 ansible_host=YOUR_SECOND_IP ansible_user=ec2-user
```

## Next Steps

1. **SSL/HTTPS**: Add Let's Encrypt certificate
2. **Monitoring**: Set up CloudWatch or Prometheus
3. **Backups**: Configure MongoDB backups
4. **CI/CD**: Automate deployment on git push
5. **Scaling**: Add load balancer for multiple instances

## Assignment Requirements ✅

- [x] Uses `site.yml` as main playbook
- [x] Uses `inventory.ini` for server inventory
- [x] Deploys web application from GitHub
- [x] Configures database (MongoDB)
- [x] Sets up web server (Nginx)
- [x] Automates complete deployment
- [x] Handles service management

## Support

For issues or questions:
1. Check application logs: `sudo journalctl -u todoapp -f`
2. Verify all services are running
3. Ensure security group allows HTTP traffic
4. Check GitHub repository is accessible
