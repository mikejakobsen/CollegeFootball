//
//  AppDelegate.swift
//  CollegeFootball
//
//  Created by Kaj Schermer Didriksen on 07/10/2016.
//  Copyright © 2016 Kaj Schermer Didriksen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let stateController = StateController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        stateController.getData()
        
        if let firstViewController = window?.rootViewController as? PlayerlistViewController {
            firstViewController.stateController = stateController
            stateController.delegate = firstViewController
        }
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        stateController.save()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        stateController.save()
    }
}

