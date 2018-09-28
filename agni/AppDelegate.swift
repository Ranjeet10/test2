//
//  AppDelegate.swift
//  agni
//
//  Created by Bidhee iMac on 8/16/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import MXParallaxHeader

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate func createMenuView(){
        
        //let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        
        let mainViewController = HOME_STORY_BOARD.instantiateViewController(withIdentifier: "MXScrollingViewController") as! MXScrollingViewController
        
        let leftMenuViewController = SLIDER_STORY_BOARD.instantiateViewController(withIdentifier: "SliderVc") as! SliderVc
//        let rightMenuViewController = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! NavigationVC
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
         nvc.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nvc.navigationBar.shadowImage = UIImage()
        nvc.navigationBar.isHidden = false
        nvc.navigationBar.backgroundColor = Utility.sharedInstance.hexStringToUIColor(hex: "DF3237")
        nvc.navigationBar.tintAdjustmentMode = .normal
        
        
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftMenuViewController)
        //      slideMenuController.automaticallyAdjustsScrollViewInsets = true
        //slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
    }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.createMenuView()
        UINavigationBar.appearance().barTintColor = Utility.sharedInstance.hexStringToUIColor(hex: "DF3237")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor.white
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
    }


}

