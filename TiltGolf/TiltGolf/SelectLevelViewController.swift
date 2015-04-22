//
//  SelectLevelViewController.swift
//  TiltGolf
//
//  Created by Cesar on 4/7/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class SelectLevelViewController: UIViewController {
    
    @IBOutlet var levelButtons: [UIButton]!
    
    @IBAction func startgamePressed(sender: UIButton) {
        self.performSegueWithIdentifier("startgame_segue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "startgame_segue") {
            var childVC : GameViewController = segue.destinationViewController as GameViewController
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var levels = 1
        for var i = 0; i < levels; i++ {
            
            println(levelButtons.count  + i)
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
