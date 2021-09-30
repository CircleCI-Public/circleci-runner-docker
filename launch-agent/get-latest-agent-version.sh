#!/bin/bash
set -euo pipefail

base_url="https://circleci-binary-releases.s3.amazonaws.com/circleci-launch-agent"
agent_version=${agent_version:-$(curl -s "$base_url/release.txt")}
echo "$agent_version"
