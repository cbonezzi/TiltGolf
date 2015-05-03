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
    
    var currentLevelScore : String = String()
    
    @IBAction func nextLevelPressed() {
        CurrentLevel = CurrentLevel + 1
        self.performSegueWithIdentifier("startgame_segue", sender: self)
    }
    
    @IBAction func highscoresPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("highscores_segue", sender: self)
    }
    @IBAction func SelectLevelPressed() {

        self.performSegueWithIdentifier("selectlevel_segue", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "selectlevel_segue") {
            var childVC : SelectLevelViewController = segue.destinationViewController as! SelectLevelViewController
        }
        if (segue.identifier == "highscores_segue") {
            var childVC : HighScoreViewController = segue.destinationViewController as! HighScoreViewController
//            var curLevel = CurrentLevel
//            curLevel = curLevel - 1
//            childVC.levelLabel.text = toString(curLevel)
//            childVC.firstHighScoreLabel.text = currentLevelScore
            
        }
        else if (segue.identifier == "startgame_segue") {
            var childVC : GameViewController = segue.destinationViewController as! GameViewController
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        LevelWon = false
        // logic for unlocking next level
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let UsersFromNSUD = defaults.stringForKey("level")
        var levelUnlocked : String = UsersFromNSUD!
        var levels = 0
        
        if levelUnlocked.toInt() < 9 && CurrentLevel == levelUnlocked.toInt(){
            levels += levelUnlocked.toInt()! + 1
            LevelUnlocked = levels
            defaults.setObject(toString(levels), forKey: "level")
        }
        
        // here is where we store the current score for this level
        // on the NSUD file
        let currentcounterNSUD = defaults.stringForKey("CurrentCounter")
        var Counter : String = currentcounterNSUD!
        currentLevelScore = currentcounterNSUD!
        //let highScore = default.stringForKey("HighScores")
        defaults.setObject(Counter, forKey: "CurrentScore")
        // maybe we can use a dictionary and we store the level and the score then match those
        // look up high score and determine what if is on the top three
        // end of storing
        
        
        //var levels = 0

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
