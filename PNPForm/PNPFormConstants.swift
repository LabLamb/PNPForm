//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public struct PNPFormConstants {
    public struct UI {
        public static var BaseRowDefaultHeight: CGFloat = 45
        public static var RowIconDefaultHeight: CGFloat = 22.5
        public static var RowConfigDefaultSpacing: CGFloat = 10
        public static var RowConfigDefaultLabelWidth: CGFloat? = nil
    }
    
    public struct System {
        public static var DefaultValidatedHandler: ValidatedHandler = { row, isValid in
            row.isShowingErrorIcon = !isValid
        }
    }
}


