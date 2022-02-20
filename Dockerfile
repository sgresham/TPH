FROM ubuntu:focal

RUN apt-get update -y
RUN apt-get install ansible -y
RUN apt-get install git zsh iputils-ping nano curl unzip -y
RUN apt-get install gcc python3-dev python3-pip openssl -y
RUN curl -l https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip --output /tmp/terraform_1.1.5_linux_amd64.zip && \
        cd /tmp && \
        unzip terraform_1.1.5_linux_amd64.zip && \
        mv terraform /usr/local/sbin/terraform && \
        chmod +x /usr/local/sbin/terraform && \
        rm /tmp/terraform_1.1.5_linux_amd64.zip 
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN pip3 install pywinrm
RUN pip3 install pywinrm[credssp]
COPY requirements.yml .
RUN ansible-galaxy collection install -r requirements.yml
RUN ansible-galaxy role install -r requirements.yml
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y
RUN pip3 install linode-cli --upgrade
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN apt-get -y install locales
RUN sed -i 's/plugins=(git)/plugins=(git kube-ps1)/' /root/.zshrc 
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8 
RUN echo "PROMPT='\$(kube_ps1)'$PROMPT" >> /root/.zshrc
RUN apt-get clean 

CMD [ "zsh" ]
