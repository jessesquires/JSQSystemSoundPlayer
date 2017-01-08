# JSQSystemSoundPlayer

[![Build Status](https://secure.travis-ci.org/jessesquires/JSQSystemSoundPlayer.svg)](http://travis-ci.org/jessesquires/JSQSystemSoundPlayer) [![Version Status](https://img.shields.io/cocoapods/v/JSQSystemSoundPlayer.svg)][podLink] [![license MIT](https://img.shields.io/cocoapods/l/JSQSystemSoundPlayer.svg)][mitLink] [![codecov](https://codecov.io/gh/jessesquires/JSQSystemSoundPlayer/branch/develop/graph/badge.svg)](https://codecov.io/gh/jessesquires/JSQSystemSoundPlayer) [![Platform](https://img.shields.io/cocoapods/p/JSQSystemSoundPlayer.svg)][docsLink] [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

*A fancy Obj-C wrapper for Cocoa [System Sound Services](https://developer.apple.com/library/ios/documentation/AudioToolbox/Reference/SystemSoundServicesReference/Reference/reference.html), for iOS and OS X.*

## About

This library is a light-weight component to play sound effects in your app.
To determine your audio needs, see [Best Practices for iOS Audio](https://developer.apple.com/library/ios/DOCUMENTATION/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html#//apple_ref/doc/uid/TP40009767-CH2-SW10).

**tl;dr**
>*When your sole audio need is to play alerts and user-interface sound effects, use Core Audio’s System Sound Services.*
>
>Your sound files must be:
>
>* No longer than 30 seconds in duration
>* In linear PCM or IMA4 (IMA/ADPCM) format
>* Packaged in a `.caf`, `.aif`, or `.wav` file

If this does not fit your needs, then this library is not for you!
See [AVAudioPlayer](https://developer.apple.com/library/ios/DOCUMENTATION/AVFoundation/Reference/AVAudioPlayerClassReference/Reference/Reference.html), instead.

![screenshot ios][imgLinkiOS] &nbsp;&nbsp;&nbsp; ![screenshot osx][imgLinkOSX]

## Features

* Play sound effects and alert sounds with a single line of code
* "Play" vibration (if available on device)
* Block-based completion handlers
* Integration with `NSUserDefaults` to globally toggle sound effects in your app
* Efficient memory management
* Caches sounds (`SystemSoundID` instances) and purges on memory warning
* Works with Swift!

## Requirements

* iOS 6.0+
* OS X 10.7+
* tvOS 9.0+
* ARC

## Installation

### [CocoaPods](https://cocoapods.org) (recommended)

````ruby
pod 'JSQSystemSoundPlayer'
````

### [Carthage](https://github.com/Carthage/Carthage)

````bash
github "jessesquires/JSQSystemSoundPlayer"
````

## Documentation

Read the [docs][docsLink]. Generated with [jazzy](https://github.com/realm/jazzy). Hosted by [GitHub Pages](https://pages.github.com).

#### Generate

````bash
$ ./build_docs.sh
````

#### Preview

````bash
$ open index.html -a Safari
````

## Contribute

Please follow these sweet [contribution guidelines](https://github.com/jessesquires/HowToContribute).

## Credits

Created and maintained by [**@jesse_squires**](https://twitter.com/jesse_squires).

## License

`JSQSystemSoundPlayer` is released under an [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2013-present Jesse Squires.**

*Please provide attribution, it is greatly appreciated.*

[docsLink]:http://www.jessesquires.com/JSQSystemSoundPlayer
[podLink]:http://cocoapods.org/pods/JSQSystemSoundPlayer
[mitLink]:http://opensource.org/licenses/MIT
[imgLinkiOS]:https://raw.githubusercontent.com/jessesquires/JSQSystemSoundPlayer/develop/Screenshots/ios.png
[imgLinkOSX]:https://raw.githubusercontent.com/jessesquires/JSQSystemSoundPlayer/develop/Screenshots/osx.png
