//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://www.jessesquires.com/JSQSystemSoundPlayer
//
//
//  GitHub
//  https://github.com/jessesquires/JSQSystemSoundPlayer
//
//
//  License
//  Copyright (c) 2015 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

@import Cocoa;


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSWindow *window;

@property (weak, nonatomic) IBOutlet NSButton *soundCheckbox;

- (IBAction)playSystemSoundPressed:(NSButton *)sender;

- (IBAction)playAlertSoundPressed:(NSButton *)sender;

- (IBAction)playLongSoundPressed:(NSButton *)sender;

- (IBAction)stopPressed:(NSButton *)sender;

- (IBAction)toggleSwitch:(NSButton *)sender;

@end

