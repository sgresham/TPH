# TerriblePowerHelm

make sure docker is running. I have to run mine as local admin.
docker build -t terriblepowerhelm:1.0.0 -t terriblepowerhelm:latest .
docker container run -v \${pwd}:/data -it terriblepowerhelm:1.0.0 zsh

I like to create an alias for this for quick use

alias tph='docker run -it --rm -v $PWD:/data -v ~/.kube/config:/root/.kube/config tph zsh'

throw it somewhere useful like .bashrc

## Currently installed: - 
1. Ansible
2. Terraform 1.1.5
3. Kubectl
4. Helm
5. Google Cloud SDK
6. Linode CLI
7. Azure CLI
8. AWS CLI
9. ZSH Oh-My-Zsh
10. github CLI
11. Flux V2 CLI


## To manage Ansible collections
1. requirements.yml before build to deploy roles and collections.
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

## TODO
1. AWS CLI

# Examples

using ansible docker image

docker run -it --rm --volume ${pwd}:/data terriblepowerhelm:latest sh -c "chmod -R 0600 /data && cd /data && ansible-playbook playbooks/linux/addkeytoUbuntu.yml --ask-pass"

to test

docker run --rm --volume ${pwd}:/data terriblepowerhelm:latest sh -c "chmod -R 0600 /data && cd /data && ansible ubuntu -m ping"

example of running something
docker run -it --rm --volume ${pwd}:/data terriblepowerhelm:latest sh -c "chmod 0600 /data && cd /data && ansible-playbook playbooks/docker/sonarqube-docker.yml"

gloud login example
gcloud auth activate-service-account ansible-service-account@left-central-311603.iam.gserviceaccount.com --key-file=google.json

