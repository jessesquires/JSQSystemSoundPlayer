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

import UIKit
import JSQSystemSoundPlayer

public class ViewController : UIViewController {

    @IBOutlet public weak var soundSwitch: UISwitch!

    public override func viewDidLoad() {
        super.viewDidLoad()
        soundSwitch.on = JSQSystemSoundPlayer.sharedPlayer().on
    }
    
    @IBAction public func playSystemSoundPressed(sender: UIButton) {
        JSQSystemSoundPlayer.sharedPlayer().playSoundWithFilename("Basso", fileExtension: kJSQSystemSoundTypeAIF) { () -> Void in
            println("Sound finished playing. Executing completion block...")
        }
    }

    @IBAction public func playAlertSoundPressed(sender: UIButton) {
        JSQSystemSoundPlayer.sharedPlayer().playAlertSoundWithFilename("Funk", fileExtension: kJSQSystemSoundTypeAIFF) { () -> Void in
            
        }
    }

    @IBAction public func playVibratePressed(sender: UIButton) {
        JSQSystemSoundPlayer.sharedPlayer().playVibrateSound()
    }

    @IBAction public func playLongSoundPressed(sender: UIButton) {
        println("Playing long sound...")
        JSQSystemSoundPlayer.sharedPlayer().playSoundWithFilename("BalladPiano", fileExtension: kJSQSystemSoundTypeCAF) { () -> Void in
            println("Long sound complete!")
        }
    }

    @IBAction public func stopPressed(sender: UIButton) {
        JSQSystemSoundPlayer.sharedPlayer().stopAllSounds()
        
        // Stop playing specific sound
        // JSQSystemSoundPlayer.sharedPlayer().stopSoundWithFilename("BalladPiano")
    }

    @IBAction public func toggleSwitch(sender: UISwitch) {
        JSQSystemSoundPlayer.sharedPlayer().toggleSoundPlayerOn(sender.on)
    }

}