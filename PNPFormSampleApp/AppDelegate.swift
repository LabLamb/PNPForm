//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit
import PNPForm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PNPFormConstants.UI.RowIconDefaultHeight = PNPFormConstants.UI.BaseRowDefaultHeight * 0.75
        
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        
        self.window?.rootViewController = UINavigationController(rootViewController: SelectionViewController())
        
        return true
    }

}
