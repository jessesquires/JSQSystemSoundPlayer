//
//  Created by Jesse Squires
//  https://www.jessesquires.com
//
//
//  Documentation
//  https://jessesquires.github.io/JSQSystemSoundPlayer
//
//
//  GitHub
//  https://github.com/jessesquires/JSQSystemSoundPlayer
//
//
//  License
//  Copyright © 2013-present Jesse Squires
//  Released under an MIT license: https://opensource.org/licenses/MIT
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

