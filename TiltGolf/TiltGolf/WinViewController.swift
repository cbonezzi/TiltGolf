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
    var usernameArray: String = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        StoreUserInit()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func StoreUserInit(){
        println("editing ended")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userscore = 1
        
        usernameArray = toString(userscore)
        //usernameMostRecentScores.append(recentScore)
        //usernameHighestScore.append(higherScore)
        //usernameRegDate.append(date)
        
        defaults.setObject(usernameArray, forKey: "score")
        
    }
}
