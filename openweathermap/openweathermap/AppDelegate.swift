//
//  AppDelegate.swift
//  openweathermap
//
//  Created by Kagan Girgin on 10/07/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = SplashViewController(
            viewModel: SplashViewModel()
        )
        window?.makeKeyAndVisible()
        
        return true
    }
}
