
# Homelab Ansible (Debian Edition)

This project manages homelab infrastructure using Ansible, targeting Debian 12/13 and Raspberry Pi OS systems.

## Structure
- `roles/` — Modular Ansible roles (e.g., bootstrap, nerdfont)
- `playbooks/` — Main playbooks (e.g., `site.yml`, `bootstrap.yml`)
- `collections/` — Ansible Galaxy collections
- `TODO.md` — Task tracking and migration notes

## Local/Self-Managed Setup

Each host manages its own configuration by running Ansible playbooks locally. There is no central control node or remote orchestration.

### Prerequisites
- Ansible (>=2.15 recommended) must be installed on the host.
- The user running the playbooks must have sudo privileges.
- (Optional) Git, if you wish to pull updates from a remote repository.

### Installation
#### Install Ansible
On Debian/Ubuntu/Raspberry Pi OS:
```sh
sudo apt update
sudo apt install ansible
```
Or with pip:
```sh
pip install --user ansible
```

#### Install required collections
```sh
ansible-galaxy install -r collections/requirements.yml
```

### Usage
1. Clone this repository on the target host:
	```sh
	git clone <repo-url>
	cd homelab-ansible
	```
2. (Optional) Edit or create a local variable file if needed (see playbook documentation).
3. Run the desired playbook locally:
	```sh
	ansible-playbook -i localhost, -c local playbooks/site.yml
	# or for other playbooks:
	ansible-playbook -i localhost, -c local playbooks/bootstrap.yml
	```

You can run any playbook as needed; each is self-contained and can be executed independently.

## Notes
- This project is designed for Debian 12/13 and Raspberry Pi OS only.
- The user running Ansible must have sudo privileges for tasks requiring elevated permissions.
- See TODO.md for migration and improvement tasks.
