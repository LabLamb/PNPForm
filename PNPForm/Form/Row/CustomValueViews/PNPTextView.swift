//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPTextView: UITextView {
    
    public let placeholder: String
    
    init(placeholder: String = "") {
        self.placeholder = placeholder
        super.init(frame: .zero, textContainer: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
