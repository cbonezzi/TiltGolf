//
//  InstructionsViewController.swift
//  TiltGolf
//
//  Created by uics12 on 4/16/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class InstrunctionsViewController: UIViewController {
    
    @IBAction func backPressed(sender: UIButton) {
        self.performSegueWithIdentifier("back_to_main_segue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "back_to_main_segue") {
            var childVC : UserViews = segue.destinationViewController as! UserViews
            
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