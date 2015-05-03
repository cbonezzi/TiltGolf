//
//  HighScoreViewController.swift
//  TiltGolf
//
//  Created by uics12 on 4/29/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import Foundation
import UIKit

class HighScoreViewController : UIViewController {
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var firstHighScoreLabel: UILabel!
    @IBOutlet weak var secondHighScoreLabel: UILabel!
    @IBOutlet weak var thirdHighScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
