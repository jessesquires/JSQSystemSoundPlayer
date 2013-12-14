# JSQSystemSoundPlayer [![Build Status](https://secure.travis-ci.org/jessesquires/JSQSystemSoundPlayer.png)](http://travis-ci.org/jessesquires/JSQSystemSoundPlayer) [![Version Status](https://cocoapod-badges.herokuapp.com/v/JSQSystemSoundPlayer/badge.png)][docsLink]

A fancy Obj-C wrapper for iOS [System Sound Services](https://developer.apple.com/library/ios/documentation/AudioToolbox/Reference/SystemSoundServicesReference/Reference/reference.html).

This class is a light-weight, drop-in component to play sound effects, or other short sounds in your iOS app. 
To determine your audio needs, see [Best Practices for iOS Audio](https://developer.apple.com/library/ios/DOCUMENTATION/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html#//apple_ref/doc/uid/TP40009767-CH2-SW10).
Or, read the tl;dr version:

>*When your sole audio need is to play alerts and user-interface sound effects, use Core Audio’s System Sound Services.*
>
>Your sound files must be:
>
>* No longer than 30 seconds in duration
>* In linear PCM or IMA4 (IMA/ADPCM) format
>* Packaged in a `.caf`, `.aif`, or `.wav` file

If this does not fit your needs, then this control is not for you! 
See [AVAudioPlayer](https://developer.apple.com/library/ios/DOCUMENTATION/AVFoundation/Reference/AVAudioPlayerClassReference/Reference/Reference.html), instead.

![JSQSystemSoundPlayer Screenshot][imgLink] 

## Features

* Play sound effects and alert sounds with a single line of code
* "Play" vibration (if available on device)
* Block-based completion handlers
* Integration with `NSUserDefaults` to globally toggle sound effects in your app
* Sweet and efficient memory management
* Caches sounds (`SystemSoundID` objects) and purges on memory warning

## Requirements

* iOS 6.0+ 
* ARC

## Installation

#### From [CocoaPods](http://www.cocoapods.org)

`pod 'JSQSystemSoundPlayer'`

#### From source

* Drag the `JSQSystemSoundPlayer/` folder to your project
* Add the `AudioToolbox.framework` to your project

#### Too cool for [ARC](https://developer.apple.com/library/mac/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)?

* Add the `-fobjc-arc` compiler flag to all source files in your project in Target Settings > Build Phases > Compile Sources.

## Getting Started

````objective-c
[[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:@"mySoundFile"
                                             extension:kJSQSystemSoundTypeAIF
                                            completion:^{
                                                // completion block code
                                            }];
````

And that's all! 

String constants for file extensions provided for you: 
* `kJSQSystemSoundTypeCAF`
* `kJSQSystemSoundTypeAIF`
* `kJSQSystemSoundTypeAIFF`
* `kJSQSystemSoundTypeWAV`

Need a setting in your app's preferences to toggle sound effects on/off? `JSQSystemSoundPlayer` can do that, too! There's no need to ever check the saved settings (`[JSQSystemSoundPlayer sharedPlayer].on`) before you play a sound effect. Just play a sound like in the example above. `JSQSystemSoundPlayer` respects whatever setting has been previously saved.

````objective-c
[[JSQSystemSoundPlayer sharedPlayer] toggleSoundPlayerOn:YES];
````

Also see the included demo project: `SoundPlayerDemo.xcodeproj`

## Documentation

Documentation is [available here][docsLink] via [CocoaDocs](http://cocoadocs.org). Thanks [@CocoaDocs](https://twitter.com/CocoaDocs)!

## Donate

Support the developement of this **free**, open-source control! via [Square Cash](https://square.com/cash).

<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$1&body=Thanks for developing JSQSystemSoundPlayer!">Send $1</a> <em>Just saying thanks!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$5&body=Thanks for developing JSQSystemSoundPlayer!">Send $5</a> <em>This control is great!</em></h4>
<h4><a href="mailto:jesse.squires.developer@gmail.com?cc=cash@square.com&subject=$10&body=Thanks for developing JSQSystemSoundPlayer!">Send $10</a> <em>This totally saved me time!</em></h4>

## How To Contribute

1. [Find an issue](https://github.com/jessesquires/JSQSystemSoundPlayer/issues?sort=created&state=open) to work on, or create a new one.
2. Fork me.
3. Create a new branch with a sweet fucking name: `git checkout -b issue_<##>_<featureOrFix>`.
4. Do some motherfucking programming
5. Write Unit Tests, if you can
6. Keep your code nice and clean by adhering to Google's [Objective-C Style Guide](http://google-styleguide.googlecode.com/svn/trunk/objcguide.xml) and Apple's [Coding Guidelines for Cocoa](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html).
7. Don't break shit, especially `master`.
8. Update the documentation header comments.
9. Update the pod spec and project version numbers, adhering to the [semantic versioning](http://semver.org) specification.
10. Submit a pull request.
11. See step 1.

## Credits

Created by [@jesse_squires](https://twitter.com/jesse_squires), a [programming-motherfucker](http://programming-motherfucker.com).

Many thanks to [the contributors](https://github.com/jessesquires/JSQSystemSoundPlayer/graphs/contributors) of this project.

## Apps Using This Control

[Hemoglobe](http://bit.ly/hemoglobeapp)

[iPaint uPaint](http://bit.ly/ipupappstr)

[MUDRammer](https://itunes.apple.com/us/app/mudrammer-a-modern-mud-client/id597157072?mt=8)

## [MIT License](http://opensource.org/licenses/MIT)

You are free to use this as you please. **No attribution necessary, but much appreciated.**

Copyright &copy; 2013 Jesse Squires

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[docsLink]:http://cocoadocs.org/docsets/JSQSystemSoundPlayer/1.4.0
[imgLink]:https://raw.github.com/jessesquires/JSQSystemSoundPlayer/master/Screenshots/screenshot.png

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jessesquires/jsqsystemsoundplayer/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
