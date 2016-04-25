# CHANGELOG

The changelog for `JSQSystemSoundPlayer`. Also see the [releases](https://github.com/jessesquires/JSQSystemSoundPlayer/releases) on GitHub.

--------------------------------------

4.4.0
-----

This release closes the [4.4.0 milestone](https://github.com/jessesquires/JSQSystemSoundPlayer/issues?utf8=✓&q=milestone%3A4.4.0+).

### New

- You can now play `SystemSoundID`s directly. (#31 — thanks @lastObject! 😄)


4.3.1
-----

This release closes the [4.3.1 milestone](https://github.com/jessesquires/JSQSystemSoundPlayer/issues?utf8=✓&q=+milestone%3A4.3.1+).

- No new features, just clean up and organization.

4.3.0
-----

Added tvOS support :tada:

4.2.0
-----

You can now create a sound player instance via `init` or `initWithBundle:` instead of using the `sharedInstance`.

Technically, you always could have used `init`, but now it's more explicit and documented.

4.1.0
-----

## What's New

* Added Objective-C nullability annotations. This will greatly improve interoperability with Swift!
* See the full list of closed issues for the [4.1.0 milestone](https://github.com/jessesquires/JSQSystemSoundPlayer/issues?q=milestone%3A4.1.0).

4.0.0
-----

### Breaking API Changes

* Removed `playSoundWithFilename:fileExtension:`
Use  `playSoundWithFilename:fileExtension:completion:` instead

* Removed `playAlertSoundWithFilename:fileExtension:`
Use `playAlertSoundWithFilename:fileExtension:completion:` instead

3.0.0
-----

Now uses Cocoa Touch framework! (#12)

Carthage compatible! (#12)

Cross-platform! Now available on OS X 10.7+ (#10, #11) Thanks to @rodionovd !

Refactored example project for iOS

Added example project for OS X

2.0.1
-----

Support for [CocoaPods 0.36](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/).

See [milestone 2.0.1](https://github.com/jessesquires/JSQSystemSoundPlayer/issues?q=milestone%3A%22Release+2.0.1%22).

2.0.0 - 1.0.0
-------------

Sorry, changelog not available for releases `1.0.0` to `2.0.0`.

0.1.0
-----

Initial release!
