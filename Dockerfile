FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
                                        curl \
                                        gzip \
                                        sudo \
                                        wget \
                                        apt-transport-https \
                                        unzip \
                                        python \
                                        jq && \
                                        rm -rf /var/lib/apt/lists/*
                                        
                                        
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y \
                                        dotnet-runtime-3.1 \
                                        dotnet-sdk-3.1 && \
                                        rm -rf /var/lib/apt/lists/*

COPY --chown=root:root start.sh /root/start.sh
COPY --chown=root:root launch-task /opt/circleci/launch-task
COPY --chown=root:root launch-agent-config.yaml /opt/circleci/launch-agent-config.yaml
RUN chmod 600 /opt/circleci/launch-agent-config.yaml && \
                                        chmod 755 /opt/circleci/launch-task && \
                                        chmod +x /root/start.sh && \
                                        chmod 755 /root

RUN curl -L https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip && \
                                                                unzip awscli-bundle.zip && \
                                                                ./awscli-bundle/install -b /usr/local/bin/aws && \
                                                                rm -rf ./awscli-bundle

ENTRYPOINT ["/root/start.sh"]