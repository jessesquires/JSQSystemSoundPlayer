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

/**
 *  String constant for .caf audio file extension.
 */
extern NSString * const kJSQSystemSoundTypeCAF;

/**
 *  String constant for .aif audio file extension.
 */
extern NSString * const kJSQSystemSoundTypeAIF;

/**
 *  String constant for .aiff audio file extension.
 */
extern NSString * const kJSQSystemSoundTypeAIFF;

/**
 *  String constant for .wav audio file extension.
 */
extern NSString * const kJSQSystemSoundTypeWAV;

typedef void(^JSQSystemSoundPlayerCompletionBlock)(BOOL success);

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
 *  Plays a system sound object corresponding to an audio file with the given filename and extension. The system sound player will lazily initialize and load the file before playing it, and then cache its corresponding `SystemSoundID`. If this file has previously been played, it will be loaded from cache and played immediately.
 *
 *  @param filename  A string containing the base name of the audio file to play.
 *  @param extension A string containing the extension of the audio file to play. This parameter must be one of `kJSQSystemSoundTypeCAF`, `kJSQSystemSoundTypeAIF`, `kJSQSystemSoundTypeAIFF`, or `kJSQSystemSoundTypeWAV`.
 */
- (void)playSoundWithName:(NSString *)filename extension:(NSString *)extension;

- (void)playSoundWithName:(NSString *)filename
                extension:(NSString *)extension
               completion:(JSQSystemSoundPlayerCompletionBlock)completionBlock;

/**
 *  Plays a system sound object *as an alert* corresponding to an audio file with the given filename and extension. The system sound player will lazily initialize and load the file before playing it, and then cache its corresponding `SystemSoundID`. If this file has previously been played, it will be loaded from cache and played immediately.
 *
 *  @param filename  A string containing the base name of the audio file to play.
 *  @param extension A string containing the extension of the audio file to play. This parameter must be one of `kJSQSystemSoundTypeCAF`, `kJSQSystemSoundTypeAIF`, `kJSQSystemSoundTypeAIFF`, or `kJSQSystemSoundTypeWAV`.
 *
 *  @warning This method performs the same functions as `playSoundWithName: extension:`, with the excepion that, depending on the particular iOS device, this method may invoke vibration.
 */
- (void)playAlertSoundWithName:(NSString *)filename extension:(NSString *)extension;

- (void)playAlertSoundWithName:(NSString *)filename
                     extension:(NSString *)extension
                    completion:(JSQSystemSoundPlayerCompletionBlock)completionBlock;

/**
 *  On some iOS devices, you can call this method to invoke vibration. On other iOS devices this functionaly is not available, and calling this method does nothing.
 */
- (void)playVibrateSound;

@end
