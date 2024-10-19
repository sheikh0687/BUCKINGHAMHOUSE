//
//  AppDelegate.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit
import AVKit
import Gallery
import Stripe
import DropDown
import AVFoundation
import Alamofire
import CoreLocation
import IQKeyboardManagerSwift
//import CountryPickerView

let Kstoryboard = UIStoryboard.init(name: "Main", bundle: nil)
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        //        StripeAPI.defaultPublishableKey = "pk_test_51Nig4lKlALlMc8VzucujBi9Qyn9ZquEHQrmLTrY4NV5pNP8fKJXboOWKzReryctSyguxB9YDAAH1opzlOJTZ8MF200GcNtNipQ"
        
        StripeAPI.defaultPublishableKey = "pk_live_51Nig4lKlALlMc8Vzewjey3IJl6KnFRztmzy21SKedMZvowyJtTjvRK4VnLwVjaQBgp1DBHSp622jkVOvifvFvd8e00ltg6FQeP"
        
        Switcher.checkLogin()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
}
