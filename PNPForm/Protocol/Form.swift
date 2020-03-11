//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

protocol Form {
    func getRows(withLabelIcon labelIcon: UIImage) -> [BaseFormRow]
    func getRows(withLabelText labelText: String) -> [BaseFormRow]
    func getViews(withRowClass rowClass: AnyClass) -> [UIView]
    func prefillRows(values: [String: String])
    func extractRowValues(withLabelTextList list: [String]) -> [String: String]
}
