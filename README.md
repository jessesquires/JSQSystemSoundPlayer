# JSQSystemSoundPlayer

[![Build Status](https://secure.travis-ci.org/jessesquires/JSQSystemSoundPlayer.svg)](https://travis-ci.org/jessesquires/JSQSystemSoundPlayer) [![Version Status](https://img.shields.io/cocoapods/v/JSQSystemSoundPlayer.svg)][podLink] [![license MIT](https://img.shields.io/cocoapods/l/JSQSystemSoundPlayer.svg)][mitLink] [![codecov](https://codecov.io/gh/jessesquires/JSQSystemSoundPlayer/branch/develop/graph/badge.svg)](https://codecov.io/gh/jessesquires/JSQSystemSoundPlayer) [![Platform](https://img.shields.io/cocoapods/p/JSQSystemSoundPlayer.svg)][docsLink] [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

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

## Usage

```objc
JSQSystemSoundPlayer *sharedPlayer = [JSQSystemSoundPlayer sharedPlayer];

// Play a built-in sound
[sharedPlayer playSoundWithSoundID:1000 // new mail sound
                           asAlert:YES
                        completion:^{
                            NSLog(@"Sound finished playing. Executing completion block...");
                        }];

// Play a sound from a file
[sharedPlayer playSoundWithFilename:@"Basso"
                      fileExtension:kJSQSystemSoundTypeAIF
                         completion:^{
                             NSLog(@"Sound finished playing. Executing completion block...");
                         }];
```

## Features

* Play sound effects and alert sounds with a single line of code
* "Play" vibration (if available on device)
* Block-based completion handlers
* Integration with `NSUserDefaults` to globally toggle sound effects in your app
* Efficient memory management
* Caches sounds (`SystemSoundID` instances) and purges on memory warning
* Works with Swift!

## Requirements

* Xcode 9+
* iOS 9.0+
* tvOS 9.0+
* macOS 10.10+

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

## Contributing

Interested in making contributions to this project? Please review the guides below.

- [Contributing Guidelines](https://github.com/jessesquires/.github/blob/master/CONTRIBUTING.md)
- [Code of Conduct](https://github.com/jessesquires/.github/blob/master/CODE_OF_CONDUCT.md)
- [Support and Help](https://github.com/jessesquires/.github/blob/master/SUPPORT.md)
- [Security Policy](https://github.com/jessesquires/.github/blob/master/SECURITY.md)

Also, consider [sponsoring this project](https://www.jessesquires.com/sponsor/) or [buying my apps](https://www.hexedbits.com)! :v:

## Credits

Created and maintained by [**@jesse_squires**](https://twitter.com/jesse_squires).

## License

`JSQSystemSoundPlayer` is released under an [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2013-present Jesse Squires.**

*Please provide attribution, it is greatly appreciated.*

[docsLink]:https://jessesquires.github.io/JSQSystemSoundPlayer
[podLink]:https://cocoapods.org/pods/JSQSystemSoundPlayer
[mitLink]:https://opensource.org/licenses/MIT
[imgLinkiOS]:https://raw.githubusercontent.com/jessesquires/JSQSystemSoundPlayer/develop/Screenshots/ios.png
[imgLinkOSX]:https://raw.githubusercontent.com/jessesquires/JSQSystemSoundPlayer/develop/Screenshots/osx.png
