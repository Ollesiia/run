//
//  AppDelegate.swift
//  run
//
//  Created by Олеся Скидан on 07.05.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Проверяем, сохранен ли userID
        if let userID = ScoreGenerator.shared.getUserID(), !userID.isEmpty {
           print(userID)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let gameViewController = mainStoryboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            window?.rootViewController = gameViewController
        } else {
//            // Пользователя нет, открываем WebViewController
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let webViewController = mainStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            window?.rootViewController = webViewController
        }

        window?.makeKeyAndVisible()
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

