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

#import "ViewController.h"

#import <JSQSystemSoundPlayer/JSQSystemSoundPlayer.h>


@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.soundSwitch.on = [JSQSystemSoundPlayer sharedPlayer].on;
}

#pragma mark - Actions

- (IBAction)playSystemSoundPressed:(UIButton *)sender
{
    JSQSystemSoundPlayer *sharedPlayer = [JSQSystemSoundPlayer sharedPlayer];

    [sharedPlayer playSoundWithFilename:@"Basso"
                          fileExtension:kJSQSystemSoundTypeAIF
                             completion:^{
                                 NSLog(@"Sound finished playing. Executing completion block...");
                             }];
}

- (IBAction)playAlertSoundPressed:(UIButton *)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithFilename:@"Funk"
                                                      fileExtension:kJSQSystemSoundTypeAIFF
                                                         completion:nil];
}

- (IBAction)playVibratePressed:(UIButton *)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] playVibrateSound];
}

- (IBAction)playLongSoundPressed:(UIButton *)sender
{
    NSLog(@"Playing long sound...");
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithFilename:@"BalladPiano"
                                                 fileExtension:kJSQSystemSoundTypeCAF
                                                    completion:^{
                                                        NSLog(@"Long sound complete!");
                                                    }];
}

- (IBAction)stopPressed:(UIButton *)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] stopAllSounds];

    // Stop playing specific sound
    // [[JSQSystemSoundPlayer sharedPlayer] stopSoundWithFilename:@"BalladPiano"];
}

- (IBAction)toggleSwitch:(UISwitch *)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] toggleSoundPlayerOn:sender.on];
}

@end
