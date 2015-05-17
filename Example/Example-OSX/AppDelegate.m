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

#import "AppDelegate.h"

#import <JSQSystemSoundPlayer/JSQSystemSoundPlayer.h>


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.soundCheckbox bind:@"state"
                    toObject:[JSQSystemSoundPlayer sharedPlayer]
                 withKeyPath:@"on"
                     options:nil];
}

#pragma mark - Actions

- (IBAction)playSystemSoundPressed:(NSButton *)sender
{
    JSQSystemSoundPlayer *sharedPlayer = [JSQSystemSoundPlayer sharedPlayer];

    [sharedPlayer playSoundWithFilename:@"Basso"
                          fileExtension:kJSQSystemSoundTypeAIF
                             completion:^{
                                 NSLog(@"Sound finished playing. Executing completion block...");
                             }];
}

- (IBAction)playAlertSoundPressed:(NSButton *)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithFilename:@"Funk"
                                                      fileExtension:kJSQSystemSoundTypeAIFF
                                                         completion:nil];
}

- (IBAction)playLongSoundPressed:(NSButton *)sender
{
    NSLog(@"Playing long sound...");
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithFilename:@"BalladPiano"
                                                 fileExtension:kJSQSystemSoundTypeCAF
                                                    completion:^{
                                                        NSLog(@"Long sound complete!");
                                                    }];
}

- (IBAction)stopPressed:(NSButton *)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] stopAllSounds];

    // Stop playing specific sound
    // [[JSQSystemSoundPlayer sharedPlayer] stopSoundWithFilename:@"BalladPiano"];
}

- (IBAction)toggleSwitch:(NSButton *)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] toggleSoundPlayerOn:sender.state];
}

@end
