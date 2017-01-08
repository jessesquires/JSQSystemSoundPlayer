# Getting Started

This guide provides a brief overview for how to get started using `JSQSystemSoundPlayer`.

````swift
@import JSQSystemSoundPlayer;
````

## Playing sounds

```objc
[[JSQSystemSoundPlayer sharedPlayer] playSoundWithFilename:@"mySoundFile"
                                             fileExtension:kJSQSystemSoundTypeAIF
                                                completion:^{
                                                   // completion block code
                                                }];
```

String constants for file extensions provided for you:

* `kJSQSystemSoundTypeCAF`
* `kJSQSystemSoundTypeAIF`
* `kJSQSystemSoundTypeAIFF`
* `kJSQSystemSoundTypeWAV`

## Toggle sounds effects settings on/off

Need a setting in your app's preferences to toggle sound effects on/off? `JSQSystemSoundPlayer` can do that, too! There's no need to ever check the saved settings (`[JSQSystemSoundPlayer sharedPlayer].on`) before you play a sound effect. Just play a sound like in the example above. `JSQSystemSoundPlayer` respects whatever setting has been previously saved.

```objc
[[JSQSystemSoundPlayer sharedPlayer] toggleSoundPlayerOn:YES];
```

## Specifying a bundle

Need to load your audio resources from a specific bundle? `JSQSystemSoundPlayer` uses the main bundle by default, but you can specify another.

**NOTE:** for each sound that is played `JSQSystemSoundPlayer` will **always** search the **last specified bundle**. If you are playing sound effects from multiple bundles, you will need to specify the bundle before playing each sound.

```objc
[JSQSystemSoundPlayer sharedPlayer].bundle = [NSBundle mainBundle];
```

## Example

The included example app, `Example/Example.xcodeproj`, exercises all functionality of this framework. There are applications for iOS and OS X.
