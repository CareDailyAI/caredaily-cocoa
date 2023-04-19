#!/bin/sh

# Install CocoaPods using Homebrew.
brew install cocoapods

# Install Carthage using Homebrew.
brew install carthage

# Install dependencies you manage with CocoaPods.
# pod install

# Install dependencies you manage with Carthage.
cd ..
./build_framework.sh
