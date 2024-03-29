//
//  AppDelegate.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit
import CoreData

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

    // MARK: - Core data Persistant container

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Covid19Monitor")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \(error.localizedDescription)")
            }
        })
        return container
    }()
}

