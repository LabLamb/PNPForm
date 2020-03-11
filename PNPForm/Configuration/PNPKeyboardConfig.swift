//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public struct PNPKeyboardConfig {
    
    public let keyboardType: UIKeyboardType
    public let inputAccessoryView: UIView?
    
    public init(keyboardType: UIKeyboardType,
                inputAccessoryView: UIView?) {
        self.keyboardType = keyboardType
        self.inputAccessoryView = inputAccessoryView
    }
}
