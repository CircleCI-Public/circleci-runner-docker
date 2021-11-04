#!/bin/bash
set -euo pipefail

target_platform="$2"

if [ -z "${1-}" ]; then
  echo "Launch-agent version must be specified."
  exit 1
fi
agent_version="${1-}"
echo "Using CircleCI Launch Agent version $agent_version"

base_url="https://circleci-binary-releases.s3.amazonaws.com/circleci-launch-agent"
prefix=/opt/circleci

WORK_DIR=$HOME/launch-agent-install
mkdir -p $WORK_DIR
pushd $WORK_DIR

echo "Downloading and verifying CircleCI Launch Agent Binary"
curl -sSL "$base_url/$agent_version/checksums.txt" -o checksums.txt
IFS=" " read -r -a selected <<< "$(grep -F "$target_platform" checksums.txt)"

file=${selected[1]:1}
mkdir -p "$target_platform"
echo "Downloading CircleCI Launch Agent: $file"
curl --compressed -L "$base_url/$agent_version/$file" -o "$file"

echo "Verifying CircleCI Launch Agent download"
sha256sum --check --ignore-missing checksums.txt && chmod +x "$file"
mv "$file" "$prefix/circleci-launch-agent" || echo "Invalid checksum for CircleCI Launch Agent, please try download again"

popd
rm -rf $WORK_DIR
