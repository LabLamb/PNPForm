//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public enum RowType {
    case email(PNPKeyboardConfig? = nil)
    case password(PNPKeyboardConfig? = nil)
    case singlelineText(PNPKeyboardConfig? = nil)
    case multilineText(PNPKeyboardConfig? = nil)
    case label
    case date
    case time
    case dateAndTime
//    case phone(PNPKeyboardConfig? = nil)
//    case number(PNPKeyboardConfig? = nil)
//    case decimal(PNPKeyboardConfig? = nil)
    case `switch`
    case button(Target, Selector)
//    case check
    case segmentedControl(SegmentList = nil)
//    case picker
//    case stepper
//    case slider
    case space(UIColor)
}

public enum ValidateOption {
    case required
    case optional
    case minimumCharacter(Int)
    case matchRegex(String)
    case customLogic(ValidationLogic)
}

public enum ValidatedHandling {
    case `default`
    case custom(ValidatedHandler)
    case none
}
