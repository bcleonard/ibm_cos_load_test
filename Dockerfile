FROM openjdk:11

WORKDIR /usr/local/scripts
USER root

ARG IBM_OG_VER=1.15.1
ARG IBM_OG_URL="https://github.com/IBM/og/releases/download/v${IBM_OG_VER}/og-${IBM_OG_VER}.tar.gz"
LABEL MAINTAINER="bradley leonard <bradley@leonard.pub>"

RUN \
  echo "---===>>> install aws cli pre-req <<<===---" && \
  apt update && \
  apt install -y python3 python3-pip python3-dev build-essential jq --no-install-recommends && \
  echo "---===>>> install aws cli <<<===---" && \
  pip3 install awscli && \  
  echo "---===>>> install ibm og <<<===---" && \
  curl -o /tmp/og.tar.gz -L "${IBM_OG_URL}" && \
  mkdir -p /usr/local/og && \
  gunzip -dc /tmp/og.tar.gz | tar -xvpf - -C /usr/local/og --strip-components=1 && \
  echo "---===>>> make scripts directory <<<===---" && \
  mkdir -p /usr/local/scripts && \
  echo "---===>>> cleanup <<<===---" && \
  rm -rf -- /tmp/og.tar.gz && \
  apt -y autoremove && \
  apt clean all && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/

CMD ["/usr/local/scripts/run_og.sh"]
