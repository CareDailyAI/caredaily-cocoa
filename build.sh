#!/bin/bash

# Update Carfile path
FRAMEWORK_PATH=`find \`pwd\` -name Peoplepower | head -n 1`
echo 'git "'$FRAMEWORK_PATH'" "master"' > PeoplepowerDemo/Cartfile

cd PeoplepowerDemo

# Install Carthage
carthage update --platform iOS

# Install Cocoapods
pod install

cd ..
