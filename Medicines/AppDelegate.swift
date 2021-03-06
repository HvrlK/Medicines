//
//  AppDelegate.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/15/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error {
                fatalError("Could load data store: \(error)")
            }
        })
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = self.persistentContainer.viewContext
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        customizeAppearance()
        let defaults = UserDefaults.standard
        if let savedEmail = defaults.string(forKey: "email"), let savedPassword = defaults.string(forKey: "password") {
            let accounts = fetchRequestFromAccounts(managedObjectContext)
            for account in accounts {
                if account.email == savedEmail && account.password == savedPassword {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                        let profileViewController = (tabBarController.viewControllers![3] as! UINavigationController).topViewController as! ProfileTableViewController
                        profileViewController.account = account
                        window?.rootViewController = tabBarController
                        break
                    }
                }
            }
        }
        return true
    }

    func customizeAppearance() {
        let barTintColor = UIColor(red: 178/255, green: 212/255, blue: 255/255, alpha: 1)
        UINavigationBar.appearance().barTintColor = barTintColor
        let titleTextAttributes = [NSAttributedStringKey(rawValue:NSAttributedStringKey.foregroundColor.rawValue): UIColor(red: 23/255, green: 43/255, blue: 77/255, alpha: 1)]
        UINavigationBar.appearance().largeTitleTextAttributes = titleTextAttributes
        UITabBar.appearance().barTintColor = barTintColor
        UITabBar.appearance().tintColor = UIColor(red: 23/255, green: 43/255, blue: 77/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        window!.tintColor = UIColor(red: 23/255, green: 43/255, blue: 77/255, alpha: 1)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

