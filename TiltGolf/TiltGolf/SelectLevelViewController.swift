//
//  SelectLevelViewController.swift
//  TiltGolf
//
//  Created by Gunnar & Cesar on 4/7/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

var LevelUnlocked = 0

class SelectLevelViewController: UIViewController {
    
    @IBOutlet var levelButtons: [UIButton]!
    
    @IBAction func startgamePressed(sender: UIButton) {
        
        if (sender.tag <= LevelUnlocked)
        {
            CurrentLevel = sender.tag
       
            self.performSegueWithIdentifier("startgame_segue", sender: self)
        }
        
    }
    
    @IBAction func backPressed(sender: UIButton) {
        self.performSegueWithIdentifier("back_to_main_segue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "startgame_segue") {
            var childVC : GameViewController = segue.destinationViewController as! GameViewController
       
        }
        if (segue.identifier == "back_to_main_segue") {
            var childVC : UserViews = segue.destinationViewController as! UserViews
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var levelUnlocked : String = String()

        let defaults = NSUserDefaults.standardUserDefaults()
        if let UsersFromNSUD = defaults.stringForKey("level"){// integerForKey("1") {// stringArrayForKey("usernameArray") {
            levelUnlocked = UsersFromNSUD
        }
        var levels = 0
        levels += levelUnlocked.toInt()!
        LevelUnlocked = levels
            for var i = 0; i < levels; i++ {
                
                let newImage = UIImage(named:"small_unlock_image")
                
                let button = levelButtons[i]
                button.setBackgroundImage(newImage, forState: UIControlState.Normal)
            }
     

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
