//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak, nonatomic) IBOutlet NSButton *soundCheckbox;

- (IBAction)playSystemSoundPressed:(NSButton *)sender;

- (IBAction)playAlertSoundPressed:(NSButton *)sender;

- (IBAction)playLongSoundPressed:(NSButton *)sender;

- (IBAction)stopPressed:(NSButton *)sender;

- (IBAction)toggleSwitch:(NSButton *)sender;

@end

