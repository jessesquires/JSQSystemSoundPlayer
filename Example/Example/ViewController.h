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

@import UIKit;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;

- (IBAction)playSystemSoundPressed:(UIButton *)sender;

- (IBAction)playAlertSoundPressed:(UIButton *)sender;

- (IBAction)playVibratePressed:(UIButton *)sender;

- (IBAction)playLongSoundPressed:(UIButton *)sender;

- (IBAction)stopPressed:(UIButton *)sender;

- (IBAction)toggleSwitch:(UISwitch *)sender;

@end
