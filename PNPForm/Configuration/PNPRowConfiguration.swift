//
//  Copyright © LabLambWorks. All rights reserved.
//
import UIKit

public struct PNPRowConfiguration {
    
    public let title: String
    public let type: RowType
    public var validation: ValidateOption
    public let spacing: CGFloat
    public let labelWidth: CGFloat?
    
    public init(title: String,
                type: RowType,
                validation: ValidateOption = .optional,
                spacing: CGFloat = 0,
                labelWidth: CGFloat? = nil) {
        self.title = title
        self.type = type
        self.validation = validation
        self.spacing = spacing
        self.labelWidth = labelWidth
    }
}
