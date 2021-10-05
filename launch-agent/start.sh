#!/bin/bash
prefix=/opt/circleci
if [[ -z "${CIRCLECI_API_TOKEN}" ]]; then
  echo "No API token supplied; exiting"
  exit 1
else
  sed -i s/CIRCLECI_API_TOKEN/"${CIRCLECI_API_TOKEN}"/ $prefix/launch-agent-config.yaml
fi

sed -i s/CIRCLECI_RUNNER_NAME/"$(hostname)"/ $prefix/launch-agent-config.yaml

sed -i s=CIRCLECI_RESOURCE_CLASS="${CIRCLECI_RESOURCE_CLASS}"= $prefix/launch-agent-config.yaml

exec $prefix/circleci-launch-agent --config $prefix/launch-agent-config.yaml
