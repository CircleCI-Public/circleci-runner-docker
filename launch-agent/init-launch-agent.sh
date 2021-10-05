#!/bin/bash
set -euo pipefail

if [ -z "${1-}" ]; then
  echo "Launch-agent version must be specified."
  exit 1
fi
agent_version="${1-}"
echo "Using CircleCI Launch Agent version $agent_version"

base_url="https://circleci-binary-releases.s3.amazonaws.com/circleci-launch-agent"
prefix=/opt/circleci
mkdir -p "$prefix/workdir"

echo "Downloading and verifying CircleCI Launch Agent Binary"
curl -sSL "$base_url/$agent_version/checksums.txt" -o checksums.txt
IFS=" " read -r -a selected <<< "$(grep -F "linux/amd64" checksums.txt)"

file=${selected[1]:1}
mkdir -p "linux/amd64"
echo "Downloading CircleCI Launch Agent: $file"
curl --compressed -L "$base_url/$agent_version/$file" -o "$file"

echo "Verifying CircleCI Launch Agent download"
sha256sum --check --ignore-missing checksums.txt && chmod +x "$file"; mv "$file" "$prefix/circleci-launch-agent" || echo "Invalid checksum for CircleCI Launch Agent, please try download again"
rm checksums.txt

echo "Adding circleci user"
id -u circleci &>/dev/null || adduser --uid 1500 --disabled-password --gecos GECOS circleci
chown -R circleci ${prefix}/workdir
