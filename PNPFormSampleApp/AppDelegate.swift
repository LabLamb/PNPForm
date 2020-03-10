//
//  AppDelegate.swift
//  PNPFormSampleApp
//
//  Created by LabLamb on 11/3/2020.
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UIViewController()
        
        return true
    }

}

