# Copilot Ansible Style Instructions

- Always reference Ansible task actions with their fully-qualified collection name (e.g., ansible.builtin.apt, ansible.builtin.command, ansible.builtin.get_url, etc.).
- Always use YAML boolean values true or false for all truthy/falsey options (never use yes/no, on/off, or strings like "True").
- Review and correct any existing or generated playbooks to follow these conventions.
- Example:

```yaml
- name: Install packages
  ansible.builtin.apt:
    name: vim
    state: present
    update_cache: true
```

- Example of what NOT to do:

```yaml
- name: Install packages
  apt:
    name: vim
    state: present
    update_cache: yes
```
