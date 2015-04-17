//
//  GameScene.swift
//  TiltGolf
//
//  Created by Cesar on 4/1/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import SpriteKit
import CoreMotion

//for bit masking, not used but could be
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let EdgeBit   : UInt32 = 0b1       // 1
    static let BallBit: UInt32 = 0b10      // 2
}

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let BlockNodeCategoryName = "blockNode"
let MaxBallAcceleration: CGFloat = 400
let MaxBallSpeed: CGFloat = 200
//percentage of energy ball retains after hitting wall .1 => 10% of energy retained -no longer used
let BorderCollisionDamping: CGFloat = 0.7
//added SKPhysicis Contact Delegate if hopes of using for colusion
class GameScene: SKScene, SKPhysicsContactDelegate  {
    

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

        //only happens once
       
        // this is gravity for the world(has to be off or the ball falls to the bottom of the screen)
       // physicsWorld.gravity = CGVectorMake(0, 0)
        // physicsWorld.contactDelegate = self
        //adds a physics body around the ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        //Sets the sprite to be dynamic. This means that the physics engine will not control the movement of the monster – you will through the code you’ve already written (using move actions).
        ball.physicsBody?.dynamic = true
        
        //Sets the category bit mask to be the monsterCategory you defined earlier.
      //  ball.physicsBody?.categoryBitMask = PhysicsCategory.BallBit
        
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
         self.physicsBody?.categoryBitMask = PhysicsCategory.EdgeBit
        
        //The contactTestBitMask indicates what categories of objects this object should notify the contact listener when they intersect. You choose projectiles here.
       // self.physicsBody?.contactTestBitMask = PhysicsCategory.BallBit
        
      //  self.physicsBody?.collisionBitMask = PhysicsCategory.BallBit | PhysicsCategory.EdgeBit
        //The collisionBitMask indicates what categories of objects this object that the physics engine handle contact responses to (i.e. bounce off of). You don’t want the monster and projectile to bounce off each other – it’s OK for them to go right through each other in this game – so you set this to 0.
         ball.physicsBody?.collisionBitMask =  PhysicsCategory.EdgeBit
        
       // ball.physicsBody?.usesPreciseCollisionDetection = true
          ball.physicsBody?.affectedByGravity = false
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
        
        // 4
        newX = min(size.width, max(0, newX))
        newY = min(size.height, max(0, newY))
        
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
