//
//  Copyright © LabLambWorks. All rights reserved.
//

import XCTest
@testable import PNPForm
class PNPRowTests: XCTestCase {
    
    func test_initWithTitle_should_equal() {
        let row = PNPRow(title: "TestTitle")
        XCTAssert(row.label as? String == "TestTitle")
    }
    
    func test_initWithIcon_should_equal() {
        let row = PNPRow(icon: UIImage())
        XCTAssert(row.label as? UIImage == UIImage())
    }
    
    func test_init_with_placeholder_should_equal() {
        let config = PNPRowConfig(placeholder: "TestTitle")
        let row = PNPRow(config: config)
        XCTAssert(row.label as? String == "TestTitle")
    }
}
