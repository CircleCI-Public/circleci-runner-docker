FROM ubuntu:20.04

ARG agent_version

RUN apt-get update && apt-get install -y \
                                        curl \
                                        gzip \
                                        sudo \
                                        wget \
                                        apt-transport-https \
                                        unzip \
                                        jq && \
                                        rm -rf /var/lib/apt/lists/*

COPY --chown=root:root init-launch-agent.sh /root/init-launch-agent.sh
RUN chmod +x /root/init-launch-agent.sh
RUN /root/init-launch-agent.sh $agent_version

COPY --chown=root:root start.sh /root/start.sh
COPY --chown=root:root launch-task.sh /opt/circleci/launch-task.sh
COPY --chown=root:root launch-agent-config.yaml /opt/circleci/launch-agent-config.yaml

RUN chmod 600 /opt/circleci/launch-agent-config.yaml && \
                                        chmod 755 /opt/circleci/launch-task.sh && \
                                        chmod +x /root/start.sh && \
                                        chmod 755 /root

ENTRYPOINT ["/root/start.sh"]
