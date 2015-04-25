//
//  WinViewController.swift
//  TiltGolf
//
//  Created by uics12 on 4/20/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class WinViewController: UIViewController {
    
    @IBAction func nextLevelPressed() {
        self.performSegueWithIdentifier("nextlevel_segue", sender: self)
    }
    
    @IBAction func SelectLevelPressed() {
        self.performSegueWithIdentifier("selectlevel_segue", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "selectlevel_segue") {
            var childVC : SelectLevelViewController = segue.destinationViewController as! SelectLevelViewController
        }
        else if (segue.identifier == "nextlevel_segue") {
            var childVC : GameViewController = segue.destinationViewController as! GameViewController
        }
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
