//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public enum RowType {
    case singleLineText
    case multLineText
    case `switch`
}

public enum ValidateOption {
    case required
    case optional
    case minimumCharacter(Int)
    case pattern(ValidationPattern)
    case customPattern(String)
    case customLogic(ValidationLogic)
}

public enum ValidatedHandling {
    case `default`
    case custom(ValidatedHandler)
}

public enum ValidationPattern: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}
