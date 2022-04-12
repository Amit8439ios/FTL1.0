//
//  AppDelegate.swift
//  Proanto
//
//  Created by ROHIT on 19/03/22.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
//        UIFont.familyNames.forEach({name in
//            for font_name in UIFont.fontNames(forFamilyName: name){
//                print("\(font_name)")
//                }
//            })
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        
        //Set Window
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.setLoginScreen()
       
        return true
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
        // Saves changes in the application's managed object context before the application terminates.
    }
}

extension AppDelegate {
    //MARK: - Set Root Controller
    func setUpRootController(controller: UIViewController){
        
        self.navigationController = UINavigationController(rootViewController: controller)
        self.navigationController.navigationBar.isHidden = true
      //  self.setUpNavigationBar()
        self.navigationController.setNavigationBarHidden(true, animated: false)

    }
    
    func setLoginScreen() {
        
//        if UserDefaults.standard.value(forKey: "userId") as! String == ""{
//            self.setUpRootController(controller: LoginVC())
//        }else{
            self.setUpRootController(controller: HomeTabViewController())
       // }

        
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
        
    //MARK: - Customize Navigation Bar

    func setUpNavigationBar()  {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .red
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .red
            UINavigationBar.appearance().isTranslucent = false
        }
 
    }
}
