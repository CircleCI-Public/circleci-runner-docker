FROM ubuntu:20.04

ARG agent_version
ARG TARGETPLATFORM

RUN apt update 
RUN apt install -y curl gzip sudo wget apt-transport-https unzip jq
RUN rm -rf /var/lib/apt/lists/*

COPY --chown=root:root init-launch-agent.sh /root/init-launch-agent.sh
RUN /bin/bash /root/init-launch-agent.sh $agent_version $TARGETPLATFORM

COPY --chown=root:root start.sh /root/start.sh
COPY --chown=root:root launch-task.sh /opt/circleci/launch-task.sh

RUN chmod 755 /opt/circleci/launch-task.sh && \
                                        chmod +x /root/start.sh && \
                                        chmod 755 /root

ENTRYPOINT ["/root/start.sh"]
