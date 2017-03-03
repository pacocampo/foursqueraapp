//
//  UserService.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 23/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class UserService {
  
  var name = "Paco"
  
  //Grabar si el usuario está logueado
  func storeCredentials() {
    print(name)
    let userDefaults = UserDefaults.standard
    userDefaults.set(true, forKey: "isLogged")
  }
  
  func userIsLogged() -> Bool {
    let userDefaults = UserDefaults.standard
    guard case let logged as Bool = userDefaults.value(forKey: "isLogged") else {
      userDefaults.set(false, forKey: "isLogged")
      return false
    }
    return logged
  }
  
  class func endSession() {
    let appDomain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: appDomain)
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! ViewController
    UIApplication.shared.keyWindow?.rootViewController = vc
  }
  
  class func sendNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Evento"
    content.body = "Ya acabamos!!!!"
    content.sound = UNNotificationSound.default()
    content.userInfo = ["data": "1235"]
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    let notification = UNNotificationRequest(identifier: "push", content: content, trigger: trigger)
    
    
    let center = UNUserNotificationCenter.current()
    center.add(notification) { (error) in
      NSLog("\(error?.localizedDescription)")
    }
  }
}







