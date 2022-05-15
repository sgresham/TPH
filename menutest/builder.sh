#!/bin/bash
whiptail --msgbox "Thankyou for trying TPH (Terrible Power Helm). \
		This started out as a simple docker image to run Terraform, Ansible, Powershell and Helm (with Kubectl). \
		It has now been expanded to help create a custom tool for you to ensure a standard working environment" 10 100

CHOICES=$(whiptail --separate-output --checklist "Choose options" 10 35 5 \
  "1" "TalosCli - Kubernetes management tool for Talos OS" OFF \
  "2" "Kubectl" OFF \
  "3" "Krew - Kubernetes Plugin manager" OFF \
  "4" "Helm 3" OFF 3>&1 1>&2 2>&3 --ok-button "Next") 

if [ -z "$CHOICES" ]; then
  echo "No option was selected (user hit Cancel or unselected all options)"
else
  for CHOICE in $CHOICES; do
    case "$CHOICE" in
    "1")
      echo -e "RUN curl https://github.com/siderolabs/talos/releases/download/v1.0.0/talosctl-linux-amd64 -L -o talosctl && \n\
            cp talosctl /usr/local/bin && \n\
            chmod +x /usr/local/bin/talosctl" >> ./Dockerfile
      ;;
    "2")
      echo -e "RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl" >> ./Dockerfile
      ;;
    "3")
      echo -e "RUN set -x; cd "$(mktemp -d)" && \n\
            curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz" && \n\
            tar zxvf krew-linux_amd64.tar.gz && \n\
            KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" && \n\
            "$KREW" install krew \n
            RUN export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"" >> ./Dockerfile
      ;;
    "4")
      echo -e "RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash" >> ./Dockerfile
      ;;
    *)
      echo "Unsupported item $CHOICE!" >&2
      exit 1
      ;;
    esac
  done
fi
