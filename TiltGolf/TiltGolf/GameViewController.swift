//
//  GameViewController.swift
//  TiltGolf
//
//  Created by Cesar on 4/1/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

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

            } else
            {
                let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSceneLevel2
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
       
        /*

        let alertController = UIAlertController(title: "High Scores: " , message : "high score is: 00:00",  preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
        }
        */
        countingLabel.text = String(format:"%.2f", counter)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)

        super.viewDidLoad()
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
       
    }
    
    
     func winScreen(){
        
        self.performSegueWithIdentifier("LoseController", sender: self)
        
        
    }
    
    
    func updateCounter() {
        counter = counter - 0.01
        countingLabel.text = String(format:"%.2f", counter)
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
