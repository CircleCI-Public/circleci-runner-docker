FROM ubuntu:20.04

ARG agent_version
ARG TARGETPLATFORM
ARG UID=1500
ARG GID=1500

RUN apt update 
RUN apt install -y curl gzip sudo wget apt-transport-https unzip jq
RUN rm -rf /var/lib/apt/lists/*

RUN addgroup --gid ${GID} circleci && \
    adduser --uid ${UID} --ingroup circleci --disabled-password --gecos GECOS circleci
RUN mkdir -p /opt/circleci/workdir
RUN chown -R circleci:circleci /opt/circleci

RUN echo "circleci ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/circleci
RUN echo "DEBIAN_FRONTEND=noninteractive" > /etc/environment

USER circleci

COPY --chown=circleci:circleci init-launch-agent.sh /opt/circleci/init-launch-agent.sh
RUN /bin/bash /opt/circleci/init-launch-agent.sh $agent_version $TARGETPLATFORM

COPY --chown=circleci:circleci start.sh /opt/circleci/start.sh

ENTRYPOINT ["/opt/circleci/start.sh"]
