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
let MaxBallAcceleration: CGFloat = 400
let MaxBallSpeed: CGFloat = 200
//percentage of energy ball retains after hitting wall .1 => 10% of energy retained
let BorderCollisionDamping: CGFloat = 0.7

class GameScene: SKScene {
    
    let ball = SKSpriteNode(imageNamed: BallCategoryName)
    let wall1 = SKSpriteNode(imageNamed: BlockCategoryName)
    let wall2 = SKSpriteNode(imageNamed: BlockCategoryName)
    let wall3 = SKSpriteNode(imageNamed: BlockCategoryName)
    var ballAcceleration = CGVector(dx: 0, dy: 0)
    var ballVelocity = CGVector(dx: 0, dy: 0)
    var lastUpdateTime: CFTimeInterval = 0
    
    var accelerometerX: UIAccelerationValue = 0
    var accelerometerY: UIAccelerationValue = 0
    
    let motionManager = CMMotionManager()
    
    deinit {
        stopMonitoringAcceleration()
    }
    
   
    override func didMoveToView(view: SKView) {

        //only happens once
        
        wall1.size=CGSize(width: 250, height: 100)
        wall1.position =  CGPoint(x: 125, y: 400)
        wall2.position =  CGPoint(x: size.width - 50, y: 60)
        wall3.position =  CGPoint(x: size.width - 50, y: 60)
        addChild(wall1)
        ball.position = CGPoint(x: size.width - 50, y: 60)
        addChild(ball)
        
        startMonitoringAcceleration()
        
        //        //this is only callled once
        //        /* Setup your scene here */
        //        //let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        //        //myLabel.text = "Hello, World!";
        //        //myLabel.fontSize = 65;
        //        //myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        //
        //        // bounding ball to the visible frame (phone borders)
        //        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //        borderBody.friction = 0
        //        physicsWorld.gravity = CGVectorMake(0, 0)
        //        self.physicsBody = borderBody
    }
    func startMonitoringAcceleration() {
        
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdates()
            NSLog("accelerometer updates on...")
        }
    }
    
    func stopMonitoringAcceleration() {
        
        if motionManager.accelerometerAvailable && motionManager.accelerometerActive {
            motionManager.stopAccelerometerUpdates()
            NSLog("accelerometer updates off...")
        }
    }
    
    func updateBallAccelerationFromMotionManager() {
        
        if let acceleration = motionManager.accelerometerData?.acceleration {
            
            let FilterFactor = 0.75
            
            accelerometerX = acceleration.x * FilterFactor + accelerometerX * (1 - FilterFactor)
            accelerometerY = acceleration.y * FilterFactor + accelerometerY * (1 - FilterFactor)
            
            ballAcceleration.dy = CGFloat(accelerometerY) * MaxBallAcceleration
            ballAcceleration.dx = CGFloat(accelerometerX) * MaxBallAcceleration
        }
    }
    func updateBallMovement(dt: CFTimeInterval) {
        
        // 1
        ballVelocity.dx = ballVelocity.dx + ballAcceleration.dx * CGFloat(dt)
        ballVelocity.dy = ballVelocity.dy + ballAcceleration.dy * CGFloat(dt)
        
        // 2
        ballVelocity.dx = max(-MaxBallSpeed, min(MaxBallSpeed, ballVelocity.dx))
        ballVelocity.dy = max(-MaxBallSpeed, min(MaxBallSpeed, ballVelocity.dy))
        
        // 3
        var newX = ball.position.x + ballVelocity.dx * CGFloat(dt)
        var newY = ball.position.y + ballVelocity.dy * CGFloat(dt)
        
        // 4
      
        var collidedWithVerticalBorder = false
        var collidedWithHorizontalBorder = false
        
        
        if ballVelocity.dx < 0 && newX < (wall1.position.x + wall1.size.width/2) && newY < wall1.position.y + wall1.size.height/2 && newY > wall1.position.y - wall1.size.height/2 && newX > (wall1.position.x - wall1.size.width/2)
        {
           newX=wall1.position.x + wall1.size.width/2
            collidedWithVerticalBorder = true
            
        }
            
        else if ballVelocity.dx > 0 && newX < (wall1.position.x + wall1.size.width/2) && newY < wall1.position.y + wall1.size.height/2 && newY > wall1.position.y - wall1.size.height/2 && newX > (wall1.position.x - wall1.size.width/2)
        {
            newX=wall1.position.x - wall1.size.width/2
            collidedWithVerticalBorder = true
            
        }

        if ballVelocity.dy < 0 && newY < (wall1.position.y + wall1.size.height/2) && newX < wall1.position.x + wall1.size.width/2 && newX > wall1.position.x - wall1.size.width/2 && newY > (wall1.position.y - wall1.size.height/2)
        {
            newY=wall1.position.y - wall1.size.height/2
            collidedWithHorizontalBorder = true
            
        }
            
        else if ballVelocity.dy > 0 && newY < (wall1.position.y + wall1.size.height/2) && newX < wall1.position.x + wall1.size.width/2 && newX > wall1.position.x - wall1.size.width/2 && newY > (wall1.position.y - wall1.size.height/2)
        {
            newY=wall1.position.y + wall1.size.height/2
            collidedWithHorizontalBorder = true
            
        }

        
        if newX < 0 {
            newX = 0
            collidedWithVerticalBorder = true
        } else if newX > size.width {
            newX = size.width
            collidedWithVerticalBorder = true
        }
        
        if newY < 0 {
            newY = 0
            collidedWithHorizontalBorder = true
        } else if newY > size.height {
            newY = size.height
            collidedWithHorizontalBorder = true
        }
        
        if collidedWithVerticalBorder {
            ballAcceleration.dx = -ballAcceleration.dx * BorderCollisionDamping
            ballVelocity.dx = -ballVelocity.dx * BorderCollisionDamping
            ballAcceleration.dy = ballAcceleration.dy * BorderCollisionDamping
            ballVelocity.dy = ballVelocity.dy * BorderCollisionDamping
        }
        
        if collidedWithHorizontalBorder {
            ballAcceleration.dx = ballAcceleration.dx * BorderCollisionDamping
            ballVelocity.dx = ballVelocity.dx * BorderCollisionDamping
            ballAcceleration.dy = -ballAcceleration.dy * BorderCollisionDamping
            ballVelocity.dy = -ballVelocity.dy * BorderCollisionDamping
        }
        
        
        ball.position = CGPoint(x: newX, y: newY)
        
        
    }
    
    //if touch screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered??? */
        // to compute velocities we need delta time to multiply by points per second
        // SpriteKit returns the currentTime, delta is computed as last called time - currentTime
        let deltaTime = max(1.0/30, currentTime - lastUpdateTime)
        lastUpdateTime = currentTime
        
        updateBallAccelerationFromMotionManager()
        updateBallMovement(deltaTime)
    }
}
