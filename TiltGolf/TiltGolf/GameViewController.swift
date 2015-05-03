//
//  GameViewController.swift
//  TiltGolf
//
//  Created by Gunnar & Cesar on 4/1/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation
var LevelWon = false
var CurrentLevel = 1;
extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            
            
            if (CurrentLevel == 1)
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
                archiver.finishDecoding()
                return scene

            } else if (CurrentLevel == 2)
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel2
                archiver.finishDecoding()
                return scene
            }
            else
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel3
                archiver.finishDecoding()
                return scene
            }
            
           
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    @IBOutlet var countingLabel: UILabel!
    var counter = 45.0
    var timer = NSTimer()
    override func viewDidLoad() {
        
        countingLabel.text = String(format:"%.2f", counter)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)

        super.viewDidLoad()
        LevelWon = false
        if CurrentLevel == 1 {
            counter = 20.0
            if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = false
                skView.showsNodeCount = false
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = false
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .AspectFill
                
                skView.presentScene(scene)
                
            }
            
        }
        if CurrentLevel == 2 {
            counter = 25.0

        if let scene = GameSceneLevel2.unarchiveFromFile("GameSceneLevel2") as? GameSceneLevel2 {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = false
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        }
        
            if CurrentLevel == 3 {
                counter = 25.0
                
                if let scene = GameSceneLevel3.unarchiveFromFile("GameSceneLevel3") as? GameSceneLevel3 {
                    // Configure the view.
                    let skView = self.view as! SKView
                    skView.showsFPS = false
                    skView.showsNodeCount = false
                    
                    /* Sprite Kit applies additional optimizations to improve rendering performance */
                    skView.ignoresSiblingOrder = false
                    
                    /* Set the scale mode to scale to fit the window */
                    scene.scaleMode = .AspectFill
                    
                    skView.presentScene(scene)
                    
                }
        }
    }
    
    
     func winScreen(){
        
        self.performSegueWithIdentifier("LoseController", sender: self)
        
        
    }
    
    
    func updateCounter() {
        counter = counter - 0.01
        
        countingLabel.text = String(format:"%.2f", counter)
        if (LevelWon == true) {
            timer.invalidate()
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            // store current counter in order to retrieve it on the win view controller
            // need to use an array!
            let CurrentCounteFromNSUD = defaults.stringForKey("CurrentCounter")
            var counter : String = countingLabel.text!
            defaults.setObject(counter, forKey: "CurrentCounter")
            // end for storing
            
            self.performSegueWithIdentifier("WinController", sender: self)

            
        }
        if (counter < 0.01) {
            timer.invalidate()

            self.performSegueWithIdentifier("LoseController", sender: self)
            
            
        }
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "LoseController") {
            var childVC : LoseViewController = segue.destinationViewController as LoseViewController
        }
    }
*/

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
