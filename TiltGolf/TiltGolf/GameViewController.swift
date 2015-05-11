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
var CurrentTime = 0.0;

var HSPointsObj : [AnyObject] = []

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
            else if (CurrentLevel == 3)
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel3
                archiver.finishDecoding()
                return scene
            }
            else if (CurrentLevel == 4)
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel4
                archiver.finishDecoding()
                return scene
            } else if (CurrentLevel == 5)
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel5
                archiver.finishDecoding()
                return scene
            } else if (CurrentLevel == 6)
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel6
                archiver.finishDecoding()
                return scene
            } else if (CurrentLevel == 7)
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel7
                archiver.finishDecoding()
                return scene
            } else if (CurrentLevel == 8)
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel8
                archiver.finishDecoding()
                return scene
            }
                
            else
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel9
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
    var levelTimes = [Double](count: 9, repeatedValue: 25.00)
    var counter = 45.0
    var timer = NSTimer()
    override func viewDidLoad() {
        levelTimes[0] = 30.0
        levelTimes[3] = 30.0
        levelTimes[4] = 35.0
        
        
        countingLabel.text = String(format:"%.2f", counter)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)

        super.viewDidLoad()
        LevelWon = false
        counter = levelTimes[CurrentLevel-1]

        if CurrentLevel == 1 {
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
      
        if CurrentLevel == 4 {
            
            if let scene = GameSceneLevel4.unarchiveFromFile("GameSceneLevel4") as? GameSceneLevel4 {
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
        if CurrentLevel == 5 {
            
            if let scene = GameSceneLevel5.unarchiveFromFile("GameSceneLevel5") as? GameSceneLevel5 {
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
        if CurrentLevel == 6 {
            
            if let scene = GameSceneLevel6.unarchiveFromFile("GameSceneLevel6") as? GameSceneLevel6 {
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
        if CurrentLevel == 7 {
            
            if let scene = GameSceneLevel7.unarchiveFromFile("GameSceneLevel7") as? GameSceneLevel7 {
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
        if CurrentLevel == 8 {
            
            if let scene = GameSceneLevel8.unarchiveFromFile("GameSceneLevel8") as? GameSceneLevel8 {
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
        if CurrentLevel == 9 {
            
            if let scene = GameSceneLevel9.unarchiveFromFile("GameSceneLevel9") as? GameSceneLevel9 {
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
    
  
  
    
    func updateCounter() {
        counter = counter - 0.01
        
        countingLabel.text = String(format:"%.2f", counter)
        if (LevelWon == true) {
            timer.invalidate()
            CurrentTime = levelTimes[CurrentLevel-1] - counter
            let defaults = NSUserDefaults.standardUserDefaults()

            self.performSegueWithIdentifier("WinController", sender: self)
        }
        if (counter < 0.01) {
            timer.invalidate()
            let skView = self.view as! SKView

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
