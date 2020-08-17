//
//  AppDelegate.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

        weak var screen : UIView? = nil
        var window: UIWindow?
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = RootViewController()
            window?.makeKeyAndVisible()
            
            return true
        }

        func applicationDidEnterBackground(_ application: UIApplication) {
            saveContext()
    }
        
        func applicationWillEnterForeground(_ application: UIApplication) {}
        
        func applicationWillTerminate(_ application: UIApplication) {}
        
        func applicationWillResignActive(_ application: UIApplication) {}
        
        func applicationDidBecomeActive(_ application: UIApplication) {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "WeatherMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

//MARK: - AppDelegate declaration of rootViewController
extension AppDelegate {
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController: RootViewController {
        window!.rootViewController as! RootViewController
    }
}
