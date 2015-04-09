//
//  GameScene.swift
//  TiltGolf
//
//  Created by Cesar on 4/1/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import SpriteKit
import CoreMotion

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let BlockNodeCategoryName = "blockNode"

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        //myLabel.text = "Hello, World!";
        //myLabel.fontSize = 65;
        //myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        // bounding ball to the visible frame (phone borders)
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        let kPlayerSpeed = 250
        let ball = childNodeWithName(BallCategoryName) as SKSpriteNode //SKSpriteNode(imageNamed: "ball")
        let wall1 = SKSpriteNode(imageNamed: "blockNode")
        ball.xScale = 1.0
        ball.yScale = 1.0
        ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        
        
        //self.addChild(ball)
        
        let motionManager: CMMotionManager = CMMotionManager()
        if (motionManager.accelerometerAvailable) {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue()) {
                (data, error) in
                let currentX = ball.position.x
                let currentY = ball.position.y
                if(data.acceleration.y < -0.25) { // tilting the device to the right
                    var destY = (CGFloat(data.acceleration.y) * CGFloat(kPlayerSpeed) + CGFloat(currentY))
                    var destX = CGFloat(currentY)
                    motionManager.accelerometerActive == true;
                    let action = SKAction.moveTo(CGPointMake(destX, destY), duration: 1)
                    ball.runAction(action)
                } else if (data.acceleration.y > 0.25) { // tilting the device to the left
                    var destY = (CGFloat(data.acceleration.y) * CGFloat(kPlayerSpeed) + CGFloat(currentY))
                    var destX = CGFloat(currentY)
                    motionManager.accelerometerActive == true;
                    let action = SKAction.moveTo(CGPointMake(destX, destY), duration: 1)
                    ball.runAction(action)
                }
                else if(data.acceleration.x < -0.25) { // tilting the device to the right
                    var destX = (CGFloat(data.acceleration.x) * CGFloat(kPlayerSpeed) + CGFloat(currentX))
                    var destY = CGFloat(currentY)
                    motionManager.accelerometerActive == true;
                    let action = SKAction.moveTo(CGPointMake(destX, destY), duration: 1)
                    ball.runAction(action)
                } else if (data.acceleration.x > 0.25) { // tilting the device to the left
                    var destX = (CGFloat(data.acceleration.x) * CGFloat(kPlayerSpeed) + CGFloat(currentX))
                    var destY = CGFloat(currentY)
                    motionManager.accelerometerActive == true;
                    let action = SKAction.moveTo(CGPointMake(destX, destY), duration: 1)
                    ball.runAction(action)
                }
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.1
//            sprite.yScale = 0.1
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
