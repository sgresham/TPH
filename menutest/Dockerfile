RUN curl https://github.com/siderolabs/talos/releases/download/v1.0.0/talosctl-linux-amd64 -L -o talosctl && 
            cp talosctl /usr/local/bin && 
            chmod +x /usr/local/bin/talosctl
RUN curl -LO https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN set -x; cd /tmp/tmp.4B6jVOnYvR && 
            curl -fsSLO https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz && 
            tar zxvf krew-linux_amd64.tar.gz && 
            KREW=./krew-linux_amd64 && 
             install krew 

            RUN export PATH=/home/steve/.krew/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
