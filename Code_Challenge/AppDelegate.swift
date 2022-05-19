//
//  AppDelegate.swift
//  Code_Challenge
//
//  Created by Austin Feight on 11/25/18.
//  Copyright © 2018 JOOR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    @LazyInjected private var userRepository: UserRepositoryProtocol
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        // Short-circuit the app if running unit tests
        let isUnitTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
        if ( isUnitTesting ) {
            Resolver.registerMockServices()
            return true
        }
        #endif
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = getInitialScreen()
        window?.makeKeyAndVisible()
        
        return true
        
    }
    
    private func getInitialScreen() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var initialScreen = UIViewController()
        let isLoggedIn = userRepository.isLoggedIn
        
        if ( isLoggedIn ) {
            if let feedScreen = storyboard.instantiateViewController(withIdentifier: "FeedScreenID") as? FeedScreen {
                initialScreen = UINavigationController(rootViewController: feedScreen)
            }
        } else {
            if let loginScreen = storyboard.instantiateViewController(withIdentifier: "LoginScreenID") as? LoginScreen {
                initialScreen = UINavigationController(rootViewController: loginScreen)
            }
        }
        
        return initialScreen
        
    }
    
}

