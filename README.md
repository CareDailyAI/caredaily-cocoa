# Care Daily Cocoa

### Versioning

* [Care Daily Cocoa](https://github.com/CareDailyAI/caredaily-cocoa) v1.0

## Table of contents

* [What's included](#whats-included)
* [Care Daily Cocoa](#caredaily-cocoa)
* [Bugs and feature requests](#bugs-and-feature-requests)
* [Versioning](#versioning)
* [Creators](#creators)
* [Copyright and license](#copyright-and-license)


## What's included

Within the download you'll find the following directories and files. You'll see something like this:

```
caredaily-cocoa/
│
├── Sources/
│	│
│	├── Components/
|   │   ├── Classes/
|   │   ├── Dependencies/
|   │   ├── Models/
|   │   └── Categories/
│   │
│   ├── Peoplepower.h
│   ├── Peoplepower.m
│   ├── Peoplepower-Prefix.pch
│   ├── Peoplepower-Config.plist
│   ├── Peoplepower-Info-iOS.plist
│   ├── Peoplepower-Info-watchOS.plist
│   ├── Peoplepower-Attributions.plist
│   ├── en.lproj/
│   ├── sv.lproj/
│   └── es.lproj/ 
│	
├── Peoplepower.xcodeproj/
│	│
│	├── project.xcworkspace/
│	├── xcuserdata/
│	└── project.pbxproj 
|
├── Peoplepower.xcworkspace/
│
├── Peoplepower-Resources.podspec
├── .gitignore
├── LICENSE
├── README.md
|
├── build.sh
├── copyFramework.sh
|
├── Cartfile
├── Cartfile.resolved
├── input.xcfilelist
├── output.xcfilelist
├── input_watchOs.xcfilelist
├── output_watchOs.xcfilelist
│
├── Peoplepower\ iOSTests/
│
└── Demo/
```

## Care Daily Cocoa

The Care Daily Cocoa framework includes APIs, models/classes, and utilities for a frontend application.

Use it to:

* Incorporate Care Daily Models and APIs.  
* Define cloud and branding configurations

For examples, please refer to the Demo project provided.

For a complete definition of Care Daily's models and APIs, please refer to [IOT Apps](https://iotapps.docs.apiary.io/) on Apiary.

### Installation

This project uses both [Cocoapods](https://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage) for distribution. See each dependency management solution for detailed steps on how to incorporate this project into an application.

In brief, Carthage is used to incorporate this frameworks source files and classes, while Cocoapods is used to incorporate other resources, like localization and plist files.

### Usage

There are 2 ways to use this project.  You may choose to use the [Realm](https://realm.io) dependency to conveniently manage and store and Care Daily classes within your application, or define your own processes for managing and storing classes.

To incorporate and use Realm within your application, use the git branch `rlm`. 
To use this framework without the Realm dependency, use the git branch `master`. 

### Cloud and Brand configurations

Default Cloud and Brand configurations are described in `Peoplepower-Config.plist`.  By default, this project points to the Care Daily sandbox server, with a default app name and brand name of "peoplepower".  The settings in this file may be overwritten by copying this file into your new application workspace and renaming the file to `Peoplepower-Config-Override.plist`.  Any or all of the settings may be overwritten.  

## Bugs and feature requests

For bugs and feature requests, submit an issue on GitHub [here](https://github.com/CareDailyAI/caredaily-cocoa/issues)

## Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, Care Daily Cocoa is maintained under [the Semantic Versioning guidelines](http://semver.org/) and uses [Apple's Framewok Versions](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/VersionInformation.html).

See [the Releases section of the GitHub project](https://github.com/CareDailyAI/caredaily-cocoa/releases) for changelogs for each release version.

## Creators

**Destry Teeter**

* <https://twitter.com/destryteeter>
* <https://github.com/destryteeter>

## Copyright and license

Code and documentation Copyright 2023 People Power Company. [License](https://github.com/CareDailyAI/caredaily-cocoa/blob/master/LICENSE).
