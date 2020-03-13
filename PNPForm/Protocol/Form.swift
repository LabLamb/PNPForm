//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

protocol Form {
    func getRows(withLabelIcon labelIcon: UIImage) -> [BaseRow]
    func getRows(withLabelText labelText: String) -> [BaseRow]
    func getViews(withRowClass rowClass: AnyClass) -> [UIView]
    func validateRows()
    func prefillRows(values: [String: String])
    func extractRowValues(withLabelTextList list: [String]) -> [String: String]
}
