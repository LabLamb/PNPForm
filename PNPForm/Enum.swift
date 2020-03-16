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
    case date(format: String = "yyyy-MM-dd")
    case time(format: String = "hh:mm aa")
    case dateAndTime(format: String = "yyyy-MM-dd hh:mm aa")
    case `switch`
    case button(target: Any?, selector: Selector)
//    case check
    case segmentedControl(segments: [String]? = nil)
//    case picker
//    case stepper
//    case slider
    case space(color: UIColor)
}

public enum ValidateOption {
    case required
    case optional
    case minimumCharacter(Int)
    case matchRegex(regex: String)
    case customLogic(ValidationLogic)
}

public enum ValidatedHandling {
    case `default`
    case custom(ValidatedHandler)
    case none
}
