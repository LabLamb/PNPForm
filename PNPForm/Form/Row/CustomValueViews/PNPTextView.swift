//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPTextView: UITextView {
    
    public let placeholder: String
    
    init(placeholder: String = "",
         keyboardConfig: PNPKeyboardConfig? = nil) {
        self.placeholder = placeholder
        super.init(frame: .zero, textContainer: nil)
        
        self.textContainer.heightTracksTextView = true
        self.textContainer.widthTracksTextView = false
        self.isScrollEnabled = false
        self.textContainer.lineFragmentPadding = 0
        self.font = UITextField().font
        let inset = (PNPFormConstants.UI.BaseRowDefaultHeight - (UITextField().font?.lineHeight ?? 0)) / 2
        self.textContainerInset = .init(top: inset, left: 0, bottom: inset, right: 0)
        self.backgroundColor = .clear
        
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
