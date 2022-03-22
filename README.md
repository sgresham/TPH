# TerriblePowerHelm

make sure docker is running. I have to run mine as local admin.

### Build
docker build -t tph:latest .

### Run
docker container run --rm -it tph zsh
### with volume mount
docker container run -v \${pwd}:/data --rm -it tph zsh

### Aliases
I like to create an alias for this for quick use

alias tph='docker run -it --rm -v $PWD:/data -v ~/.kube/config:/root/.kube/config -v ~/.gitconfig:/root/.gitconfig tph zsh'

### Aliases Port Forward
If you are likely to port forward, consider adding some ports, please note that docker will not be happy if you try and spawn more than one of these.

alias tph8080='docker run -it --rm -v $PWD:/data -v ~/.kube/config:/root/.kube/config -v ~/.gitconfig:/root/.gitconfig -p 8080:8080 tph sh -c "cd /data && zsh"'

throw it somewhere useful like .bashrc

## Currently installed: - 
Apt tools
- git, zsh, iputils-ping, telnet, curl, wget, unzip, openssl
- vim, nano
- gcc, python3-dev python3-pip, jq
- locales, tzdata, dialog
- tmux, screen

Kubernetes tools
- kubectl + zsh autocomplete (see below for some aliases as well)
- Krew
- K9sCli
- Helm 3
- Flux V2
- Sealed Secrets

Ansible + plugins
### Note - edit requirements.yml before build to deploy additional roles and collections.
- collections:
  - community.general
  - azure.azcollection
  - ansible.windows
  - community.windows
  - community.docker

- roles:
  - gsoft.azure_devops_agent
  - ahuffman.resolv
  - geerlingguy.docker
  - geerlingguy.ntp

Hashicorp
- Terraform 
- Vault

 Google Cloud SDK
 Linode CLI
 Azure CLI
 AWS CLI

GitHub CLI

# Kubernetes aliases (Thanks Oh-My-Zsh) Type 'alias to get the full list'
k - kubectl
kcuc - kubectl config use-context
kcn - kubectl config set-context
kl - kubectl logs




# Examples

### Ansible

docker run -it --rm --volume ${pwd}:/data tph:latest sh -c "chmod -R 0600 /data && cd /data && ansible-playbook playbooks/linux/addkeytoUbuntu.yml --ask-pass"

docker run --rm --volume ${pwd}:/data tph:latest sh -c "chmod -R 0600 /data && cd /data && ansible ubuntu -m ping"

example of running something
docker run -it --rm --volume ${pwd}:/data tph:latest sh -c "chmod 0600 /data && cd /data && ansible-playbook playbooks/docker/sonarqube-docker.yml"

gloud login example
gcloud auth activate-service-account ansible-service-account@left-central-123456.iam.gserviceaccount.com --key-file=google.json

