//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        
        let simpleVC = UINavigationController(rootViewController: SimpleFormViewController())
        simpleVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        let iconVC = UINavigationController(rootViewController: IconFormViewController())
        iconVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        
        let tabBarController: UITabBarController = {
            let result = UITabBarController()
            result.viewControllers = [simpleVC, iconVC]
            return result
        }()
        
        self.window?.rootViewController = tabBarController
        
        return true
    }

}
