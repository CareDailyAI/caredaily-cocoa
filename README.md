# People Power Cocoa

### Versioning

* [People Power Cocoa](https://github.com/peoplepower/peoplepower-cocoa) v0.2

## Table of contents

* [What's included](#whats-included)
* [Peoplepower Cocoa](#peoplepower-cocoa)
* [Bugs and feature requests](#bugs-and-feature-requests)
* [Versioning](#versioning)
* [Creators](#creators)
* [Copyright and license](#copyright-and-license)


## What's included

Within the download you'll find the following directories and files. You'll see something like this:

```
peoplepower-cocoa/
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
│   ├── Peoplepower-Framework-Info.plist
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

## Peoplepower Cocoa

The People Power Cocoa framework includes APIs, models/classes, and utilities for a frontend application.

Use it to:

* Incorporate People Power Models and APIs.  
* Define cloud and branding configurations

For examples, please refer to the Demo project provided.

### Installation

This project uses both [Cocoapods](https://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage) for distribution. See each dependency management solution for detailed steps on how to incorporate this project into an application.

In brief, Carthage is used to incorporate this frameworks source files and classes, while Cocoapods is used to incorporate other resources, like localization and plist files.

### Usage

There are 2 ways to use this project.  You may choose to use the [Realm](https://realm.io) dependency to conveniently manage and store and people power classes within your application, or define your own processes for managing and storing classes.

To incorporate and use Realm within your application, use the git branch `rlm`. 
To use this framework without the Realm dependency, use the git branch `master`. 

### Cloud and Brand configurations

Default Cloud and Brand configurations are described in `Peoplepower-Config.plist`.  By default, this project points to the People Power sandbox server, with a default app name and brand name of "peoplepower".  The settings in this file may be overwritten by copying this file into your new application workspace and renaming the file to `Peoplepower-Config-Override.plist`.  Any or all of the settings may be overwritten.  

## Bugs and feature requests

For bugs and feature requests, submit an issue on GitHub [here](https://github.com/peoplepower/peoplepower-cocoa/issues)

## Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, Peoplepwer-Cocoa is maintained under [the Semantic Versioning guidelines](http://semver.org/) and uses [Apple's Framewok Versions](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/VersionInformation.html).

See [the Releases section of the GitHub project](https://github.com/peoplepower/peoplepower-cocoa/releases) for changelogs for each release version.

## Creators

**Destry Teeter**

* <https://twitter.com/destryteeter>
* <https://github.com/destryteeter>

## Copyright and license

Code and documentation Copyright 2021 People Power Co. [License](https://github.com/peoplepower/peoplepower-cocoa/blob/master/LICENSE).
