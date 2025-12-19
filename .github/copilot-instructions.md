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

## Idempotency & build standards

When adding playbooks that build or install software from source, follow these conventions to make them robust and idempotent:

- Use an `install_prefix` variable (default: `/usr/local`) and include it in `cmake` via `-DCMAKE_INSTALL_PREFIX={{ install_prefix }}`.
- Prefer `ansible.builtin.stat` to check for source or installed files and conditionally run `unarchive`, `configure`, `build`, and `install` tasks.
- Use `args: creates: <path>` for commands that produce files (configure -> `CMakeCache.txt` or `Makefile`; build -> binary path; install -> `{{ install_prefix }}/bin/<binary>`).
- Use `get_url` with a checksum when available; make it optional with `checksum: "{{ my_checksum | default(omit) }}"` so tasks are deterministic when a checksum is provided.
- Add `cache_valid_time` to apt tasks (e.g., `cache_valid_time: 3600`) to avoid unnecessary `apt update` runs.
- Add a lightweight version check (e.g., `command: wsjtx --version`, `failed_when: false`, `changed_when: false`) and skip build/install when the expected version is present.
- Add `tags` (e.g., `tags: [build, install, <package>]`) to key tasks to make testing and selective runs easier.
- Use `changed_when` / `failed_when` where necessary to provide clear and accurate task results for `--check` mode and CI.

Examples and patterns in existing playbooks should be followed when adding new playbooks.
