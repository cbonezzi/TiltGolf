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
let MaxPlayerAcceleration: CGFloat = 400
let MaxPlayerSpeed: CGFloat = 200

class GameScene: SKScene {
    
    let ball = SKSpriteNode(imageNamed: BallCategoryName)
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
            
            ballAcceleration.dy = CGFloat(accelerometerY) * -MaxPlayerAcceleration
            ballAcceleration.dx = CGFloat(accelerometerX) * MaxPlayerAcceleration
        }
    }
    func updateBallMovement(dt: CFTimeInterval) {
        
        // 1
        ballVelocity.dx = ballVelocity.dx + ballAcceleration.dx * CGFloat(dt)
        ballVelocity.dy = ballVelocity.dy + ballAcceleration.dy * CGFloat(dt)
        
        // 2
        ballVelocity.dx = max(-MaxPlayerSpeed, min(MaxPlayerSpeed, ballVelocity.dx))
        ballVelocity.dy = max(-MaxPlayerSpeed, min(MaxPlayerSpeed, ballVelocity.dy))
        
        // 3
        var newX = ball.position.x + ballVelocity.dx * CGFloat(dt)
        var newY = ball.position.y + ballVelocity.dy * CGFloat(dt)
        
        // 4
        newX = min(size.width, max(0, newX));
        newY = min(size.height, max(0, newY));
        
        ball.position = CGPoint(x: newX, y: newY)
    }
    
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
