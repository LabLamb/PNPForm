//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPTextField: UITextField {
    
    private let maxTextLength: Int
    
    public init(placeholder: String = "",
                maxTextLength: Int = .max) {
        self.maxTextLength = maxTextLength

        super.init(frame: .zero)
        self.placeholder = placeholder
        self.delegate = self
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
