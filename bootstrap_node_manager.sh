#!/bin/bash

# Add DNS entries on /etc/hosts or on your local DNS

create_ansible_sudo_user(){
    if ! grep -qFx "ansible ALL=(ALL) NOPASSWD:ALL" /etc/sudoers.d/ansible; then
        echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
    fi
    if ! id -u ansible; then
        adduser ansible
        usermod -aG sudo ansible
    fi
}

install_dependencies(){
    apt install -y python3-venv sshpass git
    rm -rf /home/ansible/ansible
    if [ ! -d /home/ansible/ansible_venv ]; then
        python3 -m venv /home/ansible/ansible_venv
    fi
    source /home/ansible/ansible_venv/bin/activate
    pip install -r /home/ansible/ansible/requirements.txt
}

create_and_copy_ssh_key(){
    if [ ! -f /home/ansible/.ssh/ansible ] && [ ! -f /home/ansible/.ssh/ansible.pub ]; then
        su ansible -c 'ssh-keygen -t ed25519 -f /home/ansible/.ssh/ansible -N ""'
        for i in node-manager.lan hacking-machine.lan wiki-machine.lan database-machine.lan; do ssh-copy-id -i /home/ansible/.ssh/ansible.pub root@$i; done
    fi
}

execute_bootstrap_playbook(){
    su ansible -c "source /home/ansible/ansible_venv/bin/activate; cd /home/ansible/ansible; ansible-playbook /home/ansible/ansible/playbooks/site.yml"
}

swap_to_ansible_user(){
    cd /home/ansible
    su ansible
}

current_user=$(whoami)

if [ "$current_user" = "root" ]; then
    create_ansible_sudo_user
    install_dependencies
    create_and_copy_ssh_key
    execute_bootstrap_playbook
    swap_to_ansible_user
else
    echo "Current user is $current_user. Use root user with \"su root\" and run this script again."
fi