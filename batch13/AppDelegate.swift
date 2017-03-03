//
//  AppDelegate.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 02/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let user = UserService()
    if user.userIsLogged() {
      self.goToMain()
    }
    
    //Notifications Settings
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
      if granted {
        UIApplication.shared.registerForRemoteNotifications()
      } else {
        let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
        if UIApplication.shared.canOpenURL(settingsUrl!) {
          UIApplication.shared.open(settingsUrl!)
        }
      }
      NSLog("El permiso fue \(granted)")
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
  
  func goToMain() {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController")
    window?.rootViewController = vc
  }

}

extension AppDelegate : UNUserNotificationCenterDelegate {
  //cuando la app no está activa
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    print(response.notification.request.content.userInfo)
  }
  
  //cuando la app está activa
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print(notification.request.content.userInfo)
  }
}

