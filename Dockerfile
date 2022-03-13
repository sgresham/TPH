FROM ubuntu:focal

# APT initial
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install git zsh iputils-ping nano curl unzip \ 
    gcc python3-dev python3-pip openssl \
    vim locales -y

# Ansible
COPY requirements.yml .
RUN apt-get install ansible -y
RUN ansible-galaxy collection install -r requirements.yml
RUN ansible-galaxy role install -r requirements.yml
# # Windows specific ansible addons
RUN pip3 install pywinrm
RUN pip3 install pywinrm[credssp]

# Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# google-cloud-sdk
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

# linode-cli
RUN pip3 install linode-cli --upgrade

# Azure Cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

#AWS cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    cd /tmp && \
    unzip awscliv2.zip && \
     ./aws/install && \
     rm /tmp/awscliv2.zip

# Oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh-my-zsh customizations
RUN sed -i 's/plugins=(git)/plugins=(git kube-ps1 kubectl)/' /root/.zshrc 
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8 
RUN echo "PROMPT='\$(kube_ps1)'$PROMPT" >> /root/.zshrc
RUN echo "command -v flux >/dev/null && . <(flux completion zsh)" >> /root/.zshrc
RUN alias k="kubectl"

# GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt-get update -y && apt-get install gh -y

# Flux CLI
RUN curl -sL https://fluxcd.io/install.sh | bash

# Sealed Secrets client (kubeseal)
RUN curl -sL https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.17.3/kubeseal-0.17.3-linux-amd64.tar.gz -o "/tmp/kubeseal.tar.gz" && \
    cd /tmp && tar -xzvf kubeseal.tar.gz && mv kubeseal /usr/local/bin/ && rm -f kubeseal.tar.gz

# Powershell 7
RUN DEBIAN_FRONTEND=noninteractive TZ=Australia/Sydney apt-get -y install tzdata
RUN apt-get install -y wget apt-transport-https software-properties-common && \
    curl -sL https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o /tmp/powershell.deb && \
    dpkg -i /tmp/powershell.deb && \
    apt-get update && apt-get install powershell -y && \
    rm /tmp/powershell.deb

# Hashicorp Vault
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install vault && setcap -r /usr/bin/vault

# Terraform

RUN apt-get update && apt-get install terraform

#TMUX and Screen
RUN apt-get install tmux screen -y

#Clean up
RUN apt-get clean 

# Finish
CMD [ "zsh" ]
