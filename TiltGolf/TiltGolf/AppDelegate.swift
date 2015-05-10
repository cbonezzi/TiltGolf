//
//  AppDelegate.swift
//  TiltGolf
//
//  Created by Gunnar & Cesar on 4/1/15.
//  Copyright (c) 2015 iOSClass. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // used for keeping record of levels
        let defaults = NSUserDefaults.standardUserDefaults()
        let level = 1
        let levelUnlocked = defaults.stringForKey("level")
        
        if levelUnlocked == nil {
            
            var levelLevelString: String = toString(level)
            
            defaults.setObject(levelLevelString, forKey: "level")
        }
        
        // highscores are getting stored on the NSDU file now need to 
        // create logic to store 27 of them and depending on the level store on the 
        // correct index.
        // used for keeping record of highest scores
        //let highscoreDefault = NSUserDefaults.standardUserDefaults()
        let defaultValues = NSUserDefaults.standardUserDefaults()
        let highScores = defaultValues.stringArrayForKey("HighScores")
        if (highScores == nil){
            
            var highScoresObject: [AnyObject] = []
            
            
            let maxHighScores = 26
        
        
            for index in 0...maxHighScores {
                highScoresObject.append(toString(60.00))
                defaultValues.setObject(highScoresObject, forKey: "HighScores")
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

