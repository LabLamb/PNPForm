//
//  Copyright © LabLambWorks. All rights reserved.
//

import XCTest
@testable import PNPForm

class ExtensionTests: XCTestCase {
    
    func testUIViewAddLineWillAppearMaxX() {
        let tempView = UIView()
        tempView.addLine(position: .maxXEdge, color: .black, weight: 1)
        DispatchQueue.main.async {
            let line = tempView.subviews.first(where: { view in
                print(view.frame.width)
                return view.frame.height == tempView.frame.height &&
                view.backgroundColor == UIColor.black
            })
            XCTAssert(line != nil)
        }
    }
    
}
