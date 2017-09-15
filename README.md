# Ansible Playground

Using a Docker container running `sshd` to test `ansible` locally.

## Use

Build and run the container:

```
docker build -t ssh.local .
docker run --rm --init -d -p 2222:22 ssh.local
```

Install dependencies and run `ansible`:

```
ansible-galaxy install -r roles.yml
ansible-playbook playbook.yml
```
