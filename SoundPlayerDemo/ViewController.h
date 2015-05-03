//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQSystemSoundPlayer
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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;

- (IBAction)playSystemSoundPressed:(UIButton *)sender;

- (IBAction)playAlertSoundPressed:(UIButton *)sender;

- (IBAction)playVibratePressed:(UIButton *)sender;

- (IBAction)playLongSoundPressed:(UIButton *)sender;

- (IBAction)stopPressed:(UIButton *)sender;

- (IBAction)toggleSwitch:(UISwitch *)sender;

@end
