//
//  GameScene.swift
//  TiltGolf
//
//  Created by Gunnar & Cesar on 4/1/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import SpriteKit
import CoreMotion
import UIKit

class GameSceneLevel7: SKScene, SKPhysicsContactDelegate  {
    
    
    var ball = SKSpriteNode(imageNamed: BallCategoryName)
    
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
        
        // this is gravity for the world(has to be off or the ball falls to the bottom of the screen)
        // physicsWorld.gravity = CGVectorMake(0, 0)
        // physicsWorld.contactDelegate = self
        //adds a physics body around the ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/1.8)
        //Sets the sprite to be dynamic. This means that the physics engine will not control the movement of the monster – you will through the code you’ve already written (using move actions).
        ball.physicsBody?.dynamic = true
        
        //Sets the category bit mask to be the monsterCategory you defined earlier.
        //ball.physicsBody?.categoryBitMask = PhysicsCategory.BallBit
        
        //The contactTestBitMask indicates what categories of objects this object should notify the contact listener when they intersect. You choose projectiles here.
        // ball.physicsBody?.contactTestBitMask = PhysicsCategory.EdgeBit
        
        
        
        //sets border body the size of the frame used to make sure ball doesnt go off edge
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        // 2. Set the friction of that physicsBody to 0
        borderBody.friction = 0
        
        // 3. Set physicsBody of scene to borderBody
        self.physicsBody = borderBody
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.linearDamping = 0.0
        //Sets the category bit mask to be the monsterCategory you defined earlier.
        //   self.physicsBody?.categoryBitMask = PhysicsCategory.EdgeBit
        
        //The contactTestBitMask indicates what categories of objects this object should notify the contact listener when they intersect. You choose projectiles here.
        // self.physicsBody?.contactTestBitMask = PhysicsCategory.BallBit
        
        // self.physicsBody?.collisionBitMask = PhysicsCategory.BallBit | PhysicsCategory.EdgeBit
        //The collisionBitMask indicates what categories of objects this object that the physics engine handle contact responses to (i.e. bounce off of). You don’t want the monster and projectile to bounce off each other – it’s OK for them to go right through each other in this game – so you set this to 0.
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 1.0
        
        // ball.physicsBody?.collisionBitMask =  PhysicsCategory.EdgeBit
        
        // ball.physicsBody?.usesPreciseCollisionDetection = true
        ball.physicsBody?.affectedByGravity = false
        ball.position = CGPoint(x: size.width - 50, y: 60)
        addChild(ball)
        
        startMonitoringAcceleration()
        println("ball in start position level 3")
        println(ball.position.x)
        println(ball.position.y)
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
        
        if (ball.position.x < 94 && ball.position.y > 1020.6) {
            LevelWon = true
            ball.position = CGPoint(x: 10, y: 10)
            stopMonitoringAcceleration()
            
        }
        
    }
    
    
    
    
    // if touch screen
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
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