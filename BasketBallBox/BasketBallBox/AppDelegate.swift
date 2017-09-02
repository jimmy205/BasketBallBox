//
//  AppDelegate.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/7/18.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let fmgr = FileManager.default
    let docDir = NSHomeDirectory() + "/Documents"
    var db:OpaquePointer?
 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mydb = Bundle.main.path(forResource: "mydb", ofType: "sqlite")
        print("i am : \(mydb)")
        let newdb = docDir + "/mydb.sqlite"
        if !fmgr.fileExists(atPath: docDir + "mydb.sqlite"){
            do{
                try fmgr.copyItem(atPath: mydb!, toPath: newdb)
            }catch{
                print("exist")
            }
        }
        print(docDir)
        
        if sqlite3_open(newdb,&db) == SQLITE_OK {
            print("OK")
        }else{
            print("XX")
        }
        
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

