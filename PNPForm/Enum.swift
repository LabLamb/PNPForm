//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public enum RowType {
    case email
    case password
    case singleLineText
    case multLineText
    case `switch`
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
}
