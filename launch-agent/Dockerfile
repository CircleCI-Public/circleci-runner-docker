FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
                                        curl \
                                        gzip \
                                        sudo \
                                        wget \
                                        apt-transport-https \
                                        unzip \
                                        jq && \
                                        rm -rf /var/lib/apt/lists/*

COPY --chown=root:root start.sh /root/start.sh
COPY --chown=root:root launch-task /opt/circleci/launch-task
COPY --chown=root:root launch-agent-config.yaml /opt/circleci/launch-agent-config.yaml

RUN chmod 600 /opt/circleci/launch-agent-config.yaml && \
                                        chmod 755 /opt/circleci/launch-task && \
                                        chmod +x /root/start.sh && \
                                        chmod 755 /root

ENTRYPOINT ["/root/start.sh"]