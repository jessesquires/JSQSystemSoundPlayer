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

@interface JSQSystemSoundPlayer : NSObject

- (void)playSoundWithName:(NSString *)filename extension:(NSString *)ext;

@end
