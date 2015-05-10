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
    
    @IBOutlet weak var highScoreLabel1: UILabel!
    @IBOutlet weak var highScoreLabel2: UILabel!
    @IBOutlet weak var highScoreLabel3: UILabel!

    
    var currentLevelScore : String = String()
    
    @IBAction func nextLevelPressed() {
        CurrentLevel = CurrentLevel + 1
        self.performSegueWithIdentifier("startgame_segue", sender: self)
    }
    
   
    @IBAction func SelectLevelPressed() {

        self.performSegueWithIdentifier("selectlevel_segue", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "selectlevel_segue") {
            var childVC : SelectLevelViewController = segue.destinationViewController as! SelectLevelViewController
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
        checkCurrentScoreWithHighScore()
     
    }
    
    func checkCurrentScoreWithHighScore() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let HighScoresList = defaults.stringArrayForKey("HighScores") {
            HSPointsObj = HighScoresList as Array
            
        }
        
        defaults.setObject(HSPointsObj, forKey: "HighScores")
        var index = 0
        
        var highScoresAtCurrentLevel = (CurrentLevel - 1) * 3 + 2
        var highScoresAsDouble = [Double](count: 27, repeatedValue: 0.00)
        
        for (index, string) in enumerate(HSPointsObj) {
            highScoresAsDouble[index] = string.doubleValue
        }
        
        if (CurrentTime < highScoresAsDouble[highScoresAtCurrentLevel] ) {
            
            if (CurrentTime < highScoresAsDouble[highScoresAtCurrentLevel - 1] ){
                
                if (CurrentTime < highScoresAsDouble[highScoresAtCurrentLevel - 2] ) {
                    //make first one blue
                    highScoreLabel1.text = String(format:"%.2f", CurrentTime)
                    highScoreLabel2.text = toString(highScoresAsDouble[highScoresAtCurrentLevel - 2])
                    highScoreLabel3.text = toString(highScoresAsDouble[highScoresAtCurrentLevel - 1])
                    
                    highScoreLabel1.textColor = UIColor.blueColor()
                    highScoreLabel3.textColor = UIColor.blackColor()
                    highScoreLabel2.textColor = UIColor.blackColor()
                    
                    HSPointsObj.removeAtIndex(highScoresAtCurrentLevel)
                    var thirdHS: AnyObject = HSPointsObj.removeAtIndex(highScoresAtCurrentLevel-1)
                    var secondHS = HSPointsObj.removeAtIndex(highScoresAtCurrentLevel-2)
                    
                    HSPointsObj.insert(String(format:"%.2f", CurrentTime), atIndex: highScoresAtCurrentLevel-2)
                    HSPointsObj.insert(secondHS, atIndex: highScoresAtCurrentLevel-1)
                    
                    HSPointsObj.insert(thirdHS, atIndex: highScoresAtCurrentLevel)
                    
                    
                    
                }
                else {
                    //make 2nd one blue
                    highScoreLabel2.text = String(format:"%.2f", CurrentTime)
                    highScoreLabel1.text = toString(highScoresAsDouble[highScoresAtCurrentLevel - 2])
                    highScoreLabel3.text = toString(highScoresAsDouble[highScoresAtCurrentLevel - 1])
                    highScoreLabel2.textColor = UIColor.blueColor()
                    highScoreLabel1.textColor = UIColor.blackColor()
                    highScoreLabel3.textColor = UIColor.blackColor()
                    HSPointsObj.removeAtIndex(highScoresAtCurrentLevel)
                    var thirdHS: AnyObject = HSPointsObj.removeAtIndex(highScoresAtCurrentLevel-1)
                    
                    HSPointsObj.insert(String(format:"%.2f", CurrentTime), atIndex: highScoresAtCurrentLevel-1)
                    
                    HSPointsObj.insert(thirdHS, atIndex: highScoresAtCurrentLevel)
                    
                }
                
            }
            else {
                //make 2nd one blue
                highScoreLabel3.text = String(format:"%.2f", CurrentTime)
                highScoreLabel1.text = toString(highScoresAsDouble[highScoresAtCurrentLevel - 2])
                highScoreLabel2.text = toString(highScoresAsDouble[highScoresAtCurrentLevel - 1])
                highScoreLabel3.textColor = UIColor.blueColor()
                
                highScoreLabel1.textColor = UIColor.blackColor()
                
                highScoreLabel2.textColor = UIColor.blackColor()
                HSPointsObj.removeAtIndex(highScoresAtCurrentLevel)
                HSPointsObj.insert(String(format:"%.2f", CurrentTime), atIndex: highScoresAtCurrentLevel)
            }
            
        }
        
        else {
            highScoreLabel3.text = toString(highScoresAsDouble[highScoresAtCurrentLevel])
            highScoreLabel1.text = toString(highScoresAsDouble[highScoresAtCurrentLevel - 2])
            highScoreLabel2.text = toString(highScoresAsDouble[highScoresAtCurrentLevel - 1])
            highScoreLabel3.textColor = UIColor.blackColor()

            highScoreLabel1.textColor = UIColor.blackColor()

            highScoreLabel2.textColor = UIColor.blackColor()

        }
        
        defaults.setObject(HSPointsObj, forKey: "HighScores")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
