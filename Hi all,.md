Hi all,

It all started off with me wanting to learn how to build a tool box for my CI/CD pipelines, and turned into my universal box for all things IAC.

I am very interested in whether you would use this, and what tools I am missing that would make it even better.

https://github.com/sgresham/TPH

Currently at a hefty 3.7GB (and not hosted in DockerHub) it has the following

Apt tools

git, zsh, iputils-ping, telnet, curl, wget, unzip, openssl

vim, nano

gcc, python3-dev python3-pip, jq

locales, tzdata, dialog

tmux, screen

Kubernetes tools

kubectl + zsh autocomplete (see below for some aliases as well)

Krew

K9sCli

Helm 3

Flux V2

Sealed Secrets

Ansible + plugins

collections:

community.general

azure.azcollection

ansible.windows

community.windows

community.docker

roles:

gsoft.azure_devops_agent

ahuffman.resolv

geerlingguy.docker

geerlingguy.ntp

Hashicorp

Terraform

Vault

Google Cloud SDK

Linode CLI

Azure CLI

AWS CLI

GitHub CLI