//
//  LoseControllerScene.swift
//  TiltGolf
//
//  Created by Cesar on 4/22/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import SpriteKit

let LoseGameLabel = "GameOverLabel"

class LoseControllerScene : SKScene {
    var gameLose : Bool = false {
        didSet {
            let gameOverLabel = childNodeWithName(LoseGameLabel) as SKLabelNode!
            gameOverLabel.text = gameLose ? "You Lose" : "Game Over"
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
        if let view = view {
            let gameScene = GameScene.unarchiveFromFile("GameScene") as GameScene!
            view.presentScene(gameScene)
        }
    }
}
