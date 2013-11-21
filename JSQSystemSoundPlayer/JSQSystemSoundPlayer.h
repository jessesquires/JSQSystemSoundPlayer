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

extern NSString * const kJSQSystemSoundTypeCAF;
extern NSString * const kJSQSystemSoundTypeAIF;
extern NSString * const kJSQSystemSoundTypeWAV;

@interface JSQSystemSoundPlayer : NSObject

+ (JSQSystemSoundPlayer *)sharedPlayer;

- (void)playSoundWithName:(NSString *)filename extension:(NSString *)ext;

@end
