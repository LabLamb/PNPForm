//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public class PNPTextField: UITextField {
    
    private let maxTextLength: Int
    
    public init(placeholder: String = "",
                maxTextLength: Int = .max,
                keyboardConfig: PNPKeyboardConfig? = nil) {
        self.maxTextLength = maxTextLength

        super.init(frame: .zero)
        self.placeholder = placeholder
        self.delegate = self
        
        if let `keyboardConfig` = keyboardConfig {
            self.keyboardType = keyboardConfig.keyboardType
            self.inputAccessoryView = keyboardConfig.inputAccessoryView
            self.returnKeyType = keyboardConfig.keyboardReturnKeyType
            self.keyboardAppearance = keyboardConfig.keyboardAppearance
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PNPTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text?.count ?? 0 < self.maxTextLength || string == ""
    }
}
