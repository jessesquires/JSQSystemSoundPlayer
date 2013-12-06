//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQViewController.h"
#import "JSQSystemSoundPlayer.h"

@implementation JSQViewController

- (IBAction)playSystemSoundPressed:(id)sender
{
    JSQSystemSoundPlayer *sharedPlayer = [JSQSystemSoundPlayer sharedPlayer];
    
    [sharedPlayer playSoundWithName:@"Basso"
                          extension:kJSQSystemSoundTypeAIF
                         completion:^{
                             NSLog(@"Sound finished playing. Executing completion block...");
                             
                             [sharedPlayer playAlertSoundWithName:@"Funk"
                                                        extension:kJSQSystemSoundTypeAIFF];
                         }];
}

- (IBAction)playAlertSoundPressed:(id)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithName:@"Funk"
                                                      extension:kJSQSystemSoundTypeAIFF];
}

- (IBAction)playVibratePressed:(id)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] playVibrateSound];
}

- (IBAction)playLongSoundPressed:(id)sender
{
    NSLog(@"Playing long sound...");
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:@"BalladPiano"
                                                 extension:kJSQSystemSoundTypeCAF
                                                completion:^{
                                                    NSLog(@"Long sound complete!");
                                                }];
}

- (IBAction)stopPressed:(id)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] stopAllSounds];
}

@end
