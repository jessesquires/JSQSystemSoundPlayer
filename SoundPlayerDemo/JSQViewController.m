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

- (IBAction)playPressed:(id)sender
{
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:@"Basso"
                                                 extension:kJSQSystemSoundTypeAIF];
}

@end
