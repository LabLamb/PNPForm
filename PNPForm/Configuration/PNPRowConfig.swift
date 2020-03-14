//
//  Copyright © LabLambWorks. All rights reserved.
//
import UIKit

public struct PNPRowConfig {
    
    public let type: RowType
    public let validation: ValidateOption?
    public let validatedHandling: ValidatedHandling
    public let placeholder: String?
    public let spacing: CGFloat
    public let labelWidth: CGFloat?
    
    public init(type: RowType = .singlelineText(),
                placeholder: String? = nil,
                spacing: CGFloat = PNPFormConstants.UI.RowConfigDefaultSpacing,
                labelWidth: CGFloat? = PNPFormConstants.UI.RowConfigDefaultLabelWidth,
                validation: ValidateOption? = nil,
                validatedHandling: ValidatedHandling = .default) {
        self.type = type
        self.validation = validation
        self.validatedHandling = validatedHandling
        self.placeholder = placeholder
        self.spacing = spacing
        self.labelWidth = labelWidth
    }
}
