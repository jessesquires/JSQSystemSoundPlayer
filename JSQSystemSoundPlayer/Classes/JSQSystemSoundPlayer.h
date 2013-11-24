//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

/**
 *  String constant for .caf audio file extension.
 */
extern NSString * const kJSQSystemSoundTypeCAF;

/**
 *  String constant for .aif audio file extension.
 */
extern NSString * const kJSQSystemSoundTypeAIF;

/**
 *  String constant for .wav audio file extension.
 */
extern NSString * const kJSQSystemSoundTypeWAV;

/**
 *  The `JSQSystemSoundPlayer` class enables you to play sound effects, alert sounds, or other short sounds. It lazily loads and caches all `SystemSoundID`s and purges them upon receiving the `UIApplicationDidReceiveMemoryWarningNotification` notification.
 */
@interface JSQSystemSoundPlayer : NSObject

/**
 *  Returns the shared `JSQSystemSoundPlayer` object. This method always returns the same sound system player object.
 *
 *  @return An initialized `JSQSystemSoundPlayer` object if successful, `nil` otherwise.
 */
+ (JSQSystemSoundPlayer *)sharedPlayer;

/**
 *  Plays an audio file with the given filename and extension. The system sound player will lazily initialize and load the file before playing it, and then cache its corresponding `SystemSoundID`. If this file has previously been played, it will be loaded from cache and played immediately.
 *
 *  @param filename  A string containing the base name of the audio file to play.
 *  @param extension A string containing the extension of the audio file to play. This parameter must be one of `kJSQSystemSoundTypeCAF`, `kJSQSystemSoundTypeAIF`, or `kJSQSystemSoundTypeWAV`.
 */
- (void)playSoundWithName:(NSString *)filename extension:(NSString *)extension;

/** Vibrate the device
 *  - iOS only
 *  - on a device with no vibration capability (like iPod Touch) this will do nothing
 */
- (void)vibrate;

/** Stops all currently playing sounds
 *  - causes release of previously loaded sounds from memory
 */
- (void)stopAllSoundsImmediately;
@end
