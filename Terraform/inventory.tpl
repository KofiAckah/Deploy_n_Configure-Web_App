[webservers]
webapp ansible_host=${instance_ip}

[webservers:vars]
ansible_user=${ansible_user}
ansible_ssh_private_key_file=${private_key_path}
ansible_python_interpreter=${python_interpreter}
