//
//  Copyright © LabLambWorks. All rights reserved.
//
import UIKit

public struct PNPRowConfig {
    
    public let type: RowType
    public let validation: ValidateOption
    public let validatedHandling: ValidatedHandling
    public let placeholder: String?
    public let keyboardConfig: PNPKeyboardConfig?
    public let spacing: CGFloat
    public let labelWidth: CGFloat?
    
    public init(type: RowType = .singleLineText,
                placeholder: String? = nil,
                spacing: CGFloat = PNPFormConstants.UI.RowConfigDefaultSpacing,
                labelWidth: CGFloat? = nil,
                keyboardConfig: PNPKeyboardConfig? = nil,
                validation: ValidateOption = .optional,
                validatedHandling: ValidatedHandling = .default) {
        self.type = type
        self.validation = validation
        self.validatedHandling = validatedHandling
        self.placeholder = placeholder
        self.keyboardConfig = keyboardConfig
        self.spacing = spacing
        self.labelWidth = labelWidth
    }
}
