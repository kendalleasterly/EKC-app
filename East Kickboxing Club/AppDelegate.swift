//
//  AppDelegate.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import UIKit
import Firebase
import GoogleSignIn
import Stripe

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let googleDelegate: GoogleDelegate
    var navigationModel: NavigationModel
    
    override init() {
        
        
        let navigationModel = NavigationModel()
        let googleDelegate = GoogleDelegate(navigationModel: navigationModel)
        
        self.navigationModel = navigationModel
        self.googleDelegate = googleDelegate
        
        super.init()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = googleDelegate
        
        StripeAPI.defaultPublishableKey = "pk_test_51I2xqcGzyM7sApL2CXUYBTFTgFzGZm5d05J2B0AxN0RGk6i0CyXkFGxnlJXMo2dOOI3ejHZyp3YEzMWOSDr01zDQ00Y27tApui"
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }


}

