#!/bin/bash
prefix=/opt/circleci
if [ -z "${CIRCLECI_API_TOKEN}" -a -z "${LAUNCH_AGENT_API_AUTH_TOKEN}" ]; then
  echo "No API token supplied; exiting"
  exit 1
fi

if [[ -z "${LAUNCH_AGENT_API_AUTH_TOKEN}" ]]; then
  export LAUNCH_AGENT_API_AUTH_TOKEN=$CIRCLECI_API_TOKEN
fi

if [[ -z "${LAUNCH_AGENT_RUNNER_NAME}" ]]; then
  export LAUNCH_AGENT_RUNNER_NAME=$(hostname)
fi

export LAUNCH_AGENT_RUNNER_WORK_DIR="/opt/circleci/workdir/%s"
export LAUNCH_AGENT_RUNNER_DISABLE_AUTO_UPDATE=true
export LAUNCH_AGENT_RUNNER_CLEANUP_WORK_DIR=true

exec $prefix/circleci-launch-agent
