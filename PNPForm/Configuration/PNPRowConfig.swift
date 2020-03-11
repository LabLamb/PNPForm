//
//  Copyright © LabLambWorks. All rights reserved.
//
import UIKit

public struct PNPRowConfig {
    
    public let type: RowType
    public let validation: ValidateOption
    public let placeholder: String?
    public let keyboardConfig: PNPKeyboardConfig?
    public let spacing: CGFloat
    public let labelWidth: CGFloat?
    
    public init(type: RowType = .singleLineText,
                validation: ValidateOption = .optional,
                placeholder: String? = nil,
                keyboardConfig: PNPKeyboardConfig? = nil,
                spacing: CGFloat = PNPFormConstants.UI.RowConfigDefaultSpacing,
                labelWidth: CGFloat? = nil) {
        self.type = type
        self.validation = validation
        self.placeholder = placeholder
        self.keyboardConfig = keyboardConfig
        self.spacing = spacing
        self.labelWidth = labelWidth
    }
}
