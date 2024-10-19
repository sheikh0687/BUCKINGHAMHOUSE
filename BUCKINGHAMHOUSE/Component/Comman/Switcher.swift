//
//  Switcher.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 03/08/23.
//

import Foundation
import UIKit


class Switcher {
    
    
    class func checkLogin() {
        
        let status = k.userDefault.bool(forKey: k.session.status)
        
        if status == true
        {
            let homeViewController = Kstoryboard.instantiateViewController(withIdentifier: "CartTabBarVC") as! CartTabBarVC
            let CheckViewController = UINavigationController(rootViewController: homeViewController)
            
            kAppDelegate.window?.rootViewController = CheckViewController
            kAppDelegate.window?.makeKeyAndVisible()
            
        } else {
            let rootVC = Kstoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let nav = UINavigationController(rootViewController: rootVC)
            nav.isNavigationBarHidden = true
            kAppDelegate.window!.rootViewController = nav
            kAppDelegate.window?.makeKeyAndVisible()
        }
    }
}
