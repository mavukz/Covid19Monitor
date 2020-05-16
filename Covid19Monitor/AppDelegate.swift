//
//  AppDelegate.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let welcomeScreen = UIStoryboard(name: "WelcomeScreen", bundle: .main)
        window?.rootViewController = welcomeScreen.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

