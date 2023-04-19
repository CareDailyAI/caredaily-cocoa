#!/bin/bash

# Xcode Cloud CI to build specific framework
if [ -z ${CI_PRODUCT_PLATFORM+x} ]; then PLATFORMS="ios,watchOS"; else PLATFORMS=${CI_PRODUCT_PLATFORM}; fi

# Install Carthage
carthage update --platform $PLATFORMS --use-xcframeworks --cache-builds --verbose

cd Demo

# Install Cocoapods
pod install

cd ..
