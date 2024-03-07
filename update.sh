#!/usr/bin/env bash
#
# update the AWS icons
#

set -o errexit
set -o pipefail
set -o nounset

echo "INFO: starting at $(date -u +%Y-%m-%dT%H:%M:%SZ)"

echo "INFO: downloading AWS icons"
wget \
    --quiet \
    --output-document=aws-icons.zip \
    https://d1.awsstatic.com/webteam/architecture-icons/q1-2024/Asset-Package_02062024.c893ec2a2df5a0b881da3ad9a3213e5f6c8664d4.zip

echo "INFO: unzipping AWS icons"
mkdir -p docs/images
unzip -o aws-icons.zip -d docs/images "**/*.svg"

echo "INFO: tidying up"
# get rid of dates in the directory names
mv docs/images/Architecture-Group-Icons_* docs/images/Architecture-Group-Icons
mv docs/images/Architecture-Service-Icons_* docs/images/Architecture-Service-Icons
mv docs/images/Category-Icons_* docs/images/Category-Icons
mv docs/images/Resource-Icons_* docs/images/Resource-Icons

# macos junk
rm -rf docs/images/__MACOSX

# why are there different sizes of scalable icons???
rm -rf docs/images/Category-Icons/Arch-Category_16
rm -rf docs/images/Category-Icons/Arch-Category_32
rm -rf docs/images/Category-Icons/Arch-Category_48

# cleanup zip file
rm aws-icons.zip

if [ "${GITHUB_ACTIONS:-false}" == "true" ]; then
    git add docs/images/*.svg
fi

echo "INFO: complete at $(date -u +%Y-%m-%dT%H:%M:%SZ)"
