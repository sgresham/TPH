FROM ubuntu:focal

# APT initial
RUN apt-get update -y
RUN apt-get install git zsh iputils-ping nano curl unzip \ 
    apt-get install gcc python3-dev python3-pip openssl \
    apt-get install vim locales -y

# Ansible
COPY requirements.yml .
RUN apt-get install ansible -y
RUN ansible-galaxy collection install -r requirements.yml
RUN ansible-galaxy role install -r requirements.yml
# # Windows specific ansible addons
RUN pip3 install pywinrm
RUN pip3 install pywinrm[credssp]

# Terraform
RUN curl -l https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip --output /tmp/terraform_1.1.5_linux_amd64.zip && \
        cd /tmp && \
        unzip terraform_1.1.5_linux_amd64.zip && \
        mv terraform /usr/local/sbin/terraform && \
        chmod +x /usr/local/sbin/terraform && \
        rm /tmp/terraform_1.1.5_linux_amd64.zip 

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

#AWL cli
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
RUN alias k="kubectl"

#Clean up
RUN apt-get clean 

# Finish
CMD [ "zsh" ]