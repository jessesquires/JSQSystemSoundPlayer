# JSQSystemSoundPlayer
[![Build Status](https://secure.travis-ci.org/jessesquires/JSQSystemSoundPlayer.svg)](http://travis-ci.org/jessesquires/JSQSystemSoundPlayer) [![Version Status](https://img.shields.io/cocoapods/v/JSQSystemSoundPlayer.png)][podLink] [![license MIT](https://img.shields.io/cocoapods/l/JSQSystemSoundPlayer.png)][mitLink] [![codecov.io](https://img.shields.io/codecov/c/github/jessesquires/JSQSystemSoundPlayer.svg)](http://codecov.io/github/jessesquires/JSQSystemSoundPlayer) [![Platform](https://img.shields.io/cocoapods/p/JSQSystemSoundPlayer.png)][docsLink] [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

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

### [CocoaPods](https://cocoapods.org)
````ruby
pod 'JSQSystemSoundPlayer'
````

### [Carthage](https://github.com/Carthage/Carthage)

````bash
github "jessesquires/JSQSystemSoundPlayer"
````

### Manually

1. Add the `JSQSystemSoundPlayer/` folder to your project
2. Add `AudioToolbox.framework`

## Getting Started

````swift
@import JSQSystemSoundPlayer;
````

#### Playing sounds

````objective-c
[[JSQSystemSoundPlayer sharedPlayer] playSoundWithFilename:@"mySoundFile"
                                             fileExtension:kJSQSystemSoundTypeAIF
                                                completion:^{
                                                   // completion block code
                                                }];
````

String constants for file extensions provided for you:
* `kJSQSystemSoundTypeCAF`
* `kJSQSystemSoundTypeAIF`
* `kJSQSystemSoundTypeAIFF`
* `kJSQSystemSoundTypeWAV`

#### Toggle sounds effects settings on/off

Need a setting in your app's preferences to toggle sound effects on/off? `JSQSystemSoundPlayer` can do that, too! There's no need to ever check the saved settings (`[JSQSystemSoundPlayer sharedPlayer].on`) before you play a sound effect. Just play a sound like in the example above. `JSQSystemSoundPlayer` respects whatever setting has been previously saved.

````objective-c
[[JSQSystemSoundPlayer sharedPlayer] toggleSoundPlayerOn:YES];
````

#### Specifying a bundle

Need to load your audio resources from a specific bundle? `JSQSystemSoundPlayer` uses the main bundle by default, but you can specify another.

**NOTE:** for each sound that is played `JSQSystemSoundPlayer` will **always** search the **last specified bundle**. If you are playing sound effects from multiple bundles, you will need to specify the bundle before playing each sound.

````objective-c
[JSQSystemSoundPlayer sharedPlayer].bundle = [NSBundle mainBundle];
````

#### Demo project

The included example app, `Example.xcodeproj`, exercises all functionality of this framework. There are applications for iOS as well as OS X.

#### For a good time

````objective-c
while (1) {
    [[JSQSystemSoundPlayer sharedPlayer] playVibrateSound];
}
````

## Documentation

Read the fucking [docs][docsLink]. Generated with [jazzy](https://github.com/realm/jazzy). Hosted by [GitHub Pages](https://pages.github.com).

More information on the [`gh-pages`](https://github.com/jessesquires/JSQSystemSoundPlayer/tree/gh-pages) branch.

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
[imgLinkiOS]:https://raw.githubusercontent.com/jessesquires/JSQSystemSoundPlayer/develop/screenshot-ios.png
[imgLinkOSX]:https://raw.githubusercontent.com/jessesquires/JSQSystemSoundPlayer/develop/screenshot-osx.png
