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
    case custom(ValidationLogic)
}
