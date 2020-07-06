#!/bin/bash

# Update Carfile path
FRAMEWORK_PATH=`find \`pwd\` -name Peoplepower | head -n 1`
echo 'git "'$FRAMEWORK_PATH'" "rlm"' > Demo/Cartfile

cd Demo

# Install Carthage
carthage update --platform iOS,watchOS --cache-builds

# Install Cocoapods
pod install

cd ..
