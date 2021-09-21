#!/bin/bash

set -euo pipefail

export XCODE_XCCONFIG_FILE=$PWD/carthage.xcconfig
cur_dir=$PWD
cd ..
# The commands below are executed from parent directory
carthage_command="carthage $@ --platform iOS --use-xcframeworks --no-use-binaries"
$carthage_command

cd $cur_dir
# The commands below are executed from the current directory

echo "Will remove Carthage/dSYMs folder"
rm -rf ../Carthage/dSYMs
echo "Will generate uuid dirs"
bash ./create-uuid-dirs.sh
