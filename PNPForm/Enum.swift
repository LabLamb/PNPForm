//
//  Copyright © LabLambWorks. All rights reserved.
//

public enum RowType {
    case singleLineText
    case multLineText
}

public enum ValidateOption {
    case require
    case optional
    case minimum(Int)
    case pattern(ValidationPattern)
    case customPattern(String)
    case customLogic(ValidationLogic)
}

public enum ValidationPattern: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}
