//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public struct PNPKeyboardConfig {
    
    public let keyboardType: UIKeyboardType
    public let keyboardAppearance: UIKeyboardAppearance
    public let keyboardReturnKeyType: UIReturnKeyType
    public let inputAccessoryView: UIView?
    
    public init(keyboardType: UIKeyboardType = .default,
                keyboardAppearance: UIKeyboardAppearance = .default,
                keyboardReturnKeyType: UIReturnKeyType = .default,
                inputAccessoryView: UIView? = nil) {
        self.keyboardType = keyboardType
        self.keyboardAppearance = keyboardAppearance
        self.keyboardReturnKeyType = keyboardReturnKeyType
        self.inputAccessoryView = inputAccessoryView
    }
}
