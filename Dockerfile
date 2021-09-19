FROM centos:centos8

RUN yum install epel-release  -y
RUN yum install ansible -y
RUN yum install git zsh iputils nano curl unzip -y
RUN yum install gcc python3-devel openssl-devel -y
RUN curl -l https://releases.hashicorp.com/terraform/1.0.4/terraform_1.0.4_linux_amd64.zip --output /tmp/terraform_1.0.4_linux_amd64.zip && \
        cd /tmp && \
        unzip terraform_1.0.4_linux_amd64.zip && \
        mv terraform /usr/local/sbin/terraform && \
        chmod +x /usr/local/sbin/terraform && \
        rm /tmp/terraform_1.0.4_linux_amd64.zip 
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo
RUN yum install powershell -y
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN echo -e "[azure-cli] \nname=Azure CLI \nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli \nenabled=1 \ngpgcheck=1 \ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/azure-cli.repo
RUN yum install azure-cli -y

RUN pip3 install pywinrm
RUN pip3 install pywinrm[credssp]
COPY requirements.yml .
RUN ansible-galaxy collection install -r requirements.yml
RUN ansible-galaxy role install -r requirements.yml
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
RUN echo -e "[google-cloud-sdk] \nname=Google Cloud SDK \nbaseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64 \nenabled=1 \ngpgcheck=1 \nrepo_gpgcheck=0 \ngpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg \n\thttps://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" | tee -a /etc/yum.repos.d/google-cloud-sdk.repo
RUN yum install google-cloud-sdk -y
RUN yum clean all

CMD [ "ping -c 2 localhost" ]
