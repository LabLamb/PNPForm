//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPTextView: UITextView {
    
    public let placeholder: String
    
    init(placeholder: String = "") {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
