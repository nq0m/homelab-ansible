# homelab-ansible
Ansible Playbooks for Homelab

To bootstrap a new AlmaLinux machine:

ansible-playbook -i hosts.yml bootstrap-alma.yml -k --extra-vars "hosts=foo.servers.test-net.work"

To read facts from host:

ansible -i hosts.yml all -m ansible.builtin.setup --limit nagios.servers.test-net.work