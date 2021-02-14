#!/bin/bash
# Only works on mac, probably

set -euo pipefail

gdx_version="1.9.15"
git_hash="$(git rev-parse --short HEAD)"

mkdir ../.libgdx-workspace
echo "Copying..."
cp -R * ../.libgdx-workspace/
pushd ../.libgdx-workspace
existing="BW_PACKAGE_VERSION"
replacement="${gdx_version}-BEARWAVES-${git_hash}"
find . -type f -name "pom.xml" -print0 | xargs -0 sed -i '' -e "s/$existing/$replacement/g"
mvn install
popd

rm -rf ../.libgdx-workspace

echo "Built version: ${gdx_version}-BEARWAVES-${git_hash}"
