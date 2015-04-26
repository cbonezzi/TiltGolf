//
//  LoseViewController.swift
//  TiltGolf
//
//  Created by uics12 on 4/20/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class LoseViewController: UIViewController {
    
    var currentLevel : String = String()
    
    @IBAction func tryAgainPressed() {
        self.performSegueWithIdentifier("startgame_segue", sender: self)
    }
    
    @IBAction func SelectLevelPressed() {
        self.performSegueWithIdentifier("selectlevel_segue", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "selectlevel_segue") {
            var childVC : SelectLevelViewController = segue.destinationViewController as SelectLevelViewController
        }
        else if (segue.identifier == "startgame_segue") {
            var childVC : GameViewController = segue.destinationViewController as GameViewController
        }
            
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let UsersFromNSUD = defaults.stringForKey("level")
        currentLevel = UsersFromNSUD!
        var levels = 0
        
        if currentLevel.toInt() < 9 {
            levels += currentLevel.toInt()! + 1
            defaults.setObject(toString(levels), forKey: "level")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
