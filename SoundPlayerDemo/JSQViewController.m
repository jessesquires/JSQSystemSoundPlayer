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
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:@"Basso"
                                                 extension:kJSQSystemSoundTypeAIF
     completion:^(BOOL success) {
         NSLog(@"DID COMPLETE! success = %d", success);
         [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithName:@"Funk"
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

@end
