//
//  AppDelegate.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 14/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let loginVC = GBMLoginVC(nibName: "GBMLoginVC", bundle: nil)
        let mainNavigation = UINavigationController(rootViewController: loginVC)
        mainNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = mainNavigation
        self.window?.makeKeyAndVisible()
        return true
    }
}

