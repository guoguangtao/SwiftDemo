//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/9.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if DEBUG
        do{
            let injectionBundle = Bundle.init(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")
            if let bundle = injectionBundle{
                try bundle.loadAndReturnError()
            }else{
                yxc_debugPrintf("Injection注入失败,未能检测到Injection")
            }
            
        } catch{
            yxc_debugPrintf("Injection注入失败\(error)")
        }
        #endif
        
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

    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        let textFieldResult = YXCTextField.yxc_shouldAllowExtensionPointIdentifier(extensionPointIdentifier: extensionPointIdentifier)
        let textViewResult = YXCTextView.yxc_shouldAllowExtensionPointIdentifier(extensionPointIdentifier: extensionPointIdentifier)
        
        if textFieldResult == false || textViewResult == false {
            return false
        }
        
        return true
    }

}

