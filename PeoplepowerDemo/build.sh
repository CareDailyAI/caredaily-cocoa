#!/bin/bash

# Update Carfile path
FRAMEWORK_PATH=`find \`pwd\` -name Peoplepower | head -n 1`
echo 'git "'$FRAMEWORK_PATH'" "master"' > Cartfile

# Install Carthage
carthage update --platform iOS

# Install Cocoapods
pod install
