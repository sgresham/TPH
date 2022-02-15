# TerriblePowerHelm

make sure docker is running. I have to run mine as local admin.
docker build -t terriblepowerhelm:1.0.0 -t terriblepowerhelm:latest .
docker container run -v \${pwd}:/data -it terriblepowerhelm:1.0.0 zsh

## Currently installed: - 
1. Terraform 1.1.5
2. Ansible
3. Powershell PWSH
4. Helm 3
5. Azure CLI
6. Google Cloud SDK

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

