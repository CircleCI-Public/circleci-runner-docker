#!/bin/bash
prefix=/opt/circleci
mkdir -p "$prefix/workdir"
base_url="https://circleci-binary-releases.s3.amazonaws.com/circleci-launch-agent"
echo "Determining latest version of CircleCI Launch Agent"
agent_version=$(curl "$base_url/release.txt")
echo "Using CircleCI Launch Agent version $agent_version"
echo "Downloading and verifying CircleCI Launch Agent Binary"
curl -sSL "$base_url/$agent_version/checksums.txt" -o checksums.txt
IFS=" " read -r -a selected <<< "$(grep -F "linux/amd64" checksums.txt)"
checksum=${selected[0]}
file=${selected[1]:1}
mkdir -p "linux/amd64"
echo "Downloading CircleCI Launch Agent: $file"
curl --compressed -L "$base_url/$agent_version/$file" -o "$file"
echo "Verifying CircleCI Launch Agent download"
sha256sum --check --ignore-missing checksums.txt && chmod +x "$file"; mv "$file" "$prefix/circleci-launch-agent" || echo "Invalid checksum for CircleCI Launch Agent, please try download again"
id -u circleci &>/dev/null || adduser --uid 1500 --disabled-password --gecos GECOS circleci
chown -R circleci /opt/circleci/workdir

if [[ -z "${CIRCLECI_API_TOKEN}" ]]; then
  echo "No API token supplied; exiting"
  exit 1
else
  sed -i s/CIRCLECI_API_TOKEN/${CIRCLECI_API_TOKEN}/ /opt/circleci/launch-agent-config.yaml
fi

sed -i s/CIRCLECI_RUNNER_NAME/$(hostname)/ /opt/circleci/launch-agent-config.yaml

sed -i s/CIRCLECI_RESOURCE_CLASS/${CIRCLECI_RESOURCE_CLASS}/ /opt/circleci/launch-agent-config.yaml

/opt/circleci/circleci-launch-agent --config /opt/circleci/launch-agent-config.yaml