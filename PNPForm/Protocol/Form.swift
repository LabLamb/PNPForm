//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public protocol Form {
    func getRows() -> [BaseRow]
    func getRows(withLabelIcon labelIcon: UIImage) -> [BaseRow]
    func getRows(withLabelText labelText: String) -> [BaseRow]
    func getViews() -> [UIView]
    func getViews(withViewClass rowClass: AnyClass) -> [UIView]
    func validateRows() -> Bool
    func prefillRowsInOrder(orderedValues values: [String])
    func prefillRows(titleValueMap values: [String: String])
    func prefillRows(iconValueMap values: [UIImage: String])
    func extractRowValuesInOrder() -> [String]
    func extractRowValues(withLabelTextList list: [String]) -> [String: String]
    func extractRowValues(withLabelIconList list: [UIImage]) -> [UIImage: String]
    func appendView(view: UIView)
}
