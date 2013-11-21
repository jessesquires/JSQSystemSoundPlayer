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


@interface JSQSystemSoundPlayer : NSObject

+ (JSQSystemSoundPlayer *)sharedPlayer;

- (void)playSoundWithName:(NSString *)filename extension:(NSString *)ext;

@end
