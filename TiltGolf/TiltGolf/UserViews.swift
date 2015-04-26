//
//  UserViews.swift
//  TiltGolf
//
//  Created by Gunnar & Cesar on 4/7/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class UserViews: UIViewController {
    
    @IBAction func startGamePressed(sender: UIButton) {
        self.performSegueWithIdentifier("selectlevel_segue", sender: self)
    }
    
    @IBAction func instructionsPressed() {
        self.performSegueWithIdentifier("instructions_segue", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "selectlevel_segue") {
            var childVC : SelectLevelViewController = segue.destinationViewController as! SelectLevelViewController
        }
        else if (segue.identifier == "instructions_segue") {
            var childVC : InstrunctionsViewController = segue.destinationViewController as! InstrunctionsViewController
            
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
