//
//  Copyright © LabLambWorks. All rights reserved.
//

import XCTest
@testable import PNPForm

@available(iOS 13.0, *)
class PNPFormTests: XCTestCase {
    
    let rowTitles = [
        "Row 1",
        "Row 2",
        "Row 3"
    ]
    
    let rowIcons = [
        UIImage(systemName: "person.circle")!,
        UIImage(systemName: "envelope.circle")!,
        UIImage(systemName: "lock.circle")!
    ]
    
    let rowValues = [
        "Row 1 Value",
        "Row 2 Value",
        "Row 3 Value"
    ]
    
    func makeMockFormWithTitles() -> Form {
        return PNPForm(rows: self.rowTitles.compactMap({ PNPRow(title: $0) }), separatorColor: .black)
    }
    
    func makeMockFormWithIcons() -> Form {
        return PNPForm(rows: self.rowIcons.compactMap({ PNPRow(icon: $0) }), separatorColor: .black)
    }
    
    func makeMockFormWithPlaceholders() -> Form {
        let rows: [PNPRow] = {
            var result = [PNPRow]()
            for placeholder in rowTitles {
                let config = PNPRowConfig(placeholder: placeholder)
                let row = PNPRow(config: config)
                result.append(row)
            }
            return result
        }()
        return PNPForm(rows: rows, separatorColor: .black)
    }
    
    func makeMockFormWithRandomViews(views: [UIView]) -> Form {
        return PNPForm(rows: views, separatorColor: .black)
    }
    
    func testGetRowsShouldReturnEmptyIfNoRows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.getRows() == [])
    }
    
    func testGetRowsWithLabelIconShouldReturnEmptyNoRows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.getRows(withLabelIcon: rowIcons[0]) == [])
    }
    
    func testGetRowsWithLabelTextShouldReturnEmptyNoRows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.getRows(withLabelText: rowTitles[0]) == [])
    }
    
    func testGetViewsWithRowClassShouldReturnEmptyNoRows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.getViews(withViewClass: UIApplicationDelegate.self) == [])
    }
    
    func testExtractRowValuesInOrderShouldReturnEmptyIfNoRows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.extractRowValuesInOrder() == [])
    }
    
    func testExtractRowValuesWithLabelTextListShouldReturnEmptyIfNoRows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.extractRowValues(withLabelTextList: self.rowTitles) == [:])
    }
    
    func testExtractRowValuesWithLabelIconListShouldReturnEmptyIfNoRows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.extractRowValues(withLabelIconList: self.rowIcons) == [:])
    }
    
    func testGetRowsShouldReturnAllRows() {
        let form = self.makeMockFormWithTitles()
        let rows = form.getRows()
        for i in 0..<rows.count {
            XCTAssert(rows[i].label as? String == self.rowTitles[i])
        }
        XCTAssert(form.getRows().count == self.rowTitles.count)
    }
    
    func testGetRowsWithLabelIconShouldReturn() {
        let index = 0
        let form = self.makeMockFormWithIcons()
        let row = form.getRows(withLabelIcon: self.rowIcons[index]).first
        
        guard let labelIcon = row?.label as? UIImage else {
            XCTFail("Label Icon is not an UIImage.")
            return
        }
        XCTAssert(row != nil && labelIcon == self.rowIcons[index])
    }
    
    func testGetRowsWithLabelTitleShouldReturn() {
        let index = 0
        let form = self.makeMockFormWithTitles()
        let row = form.getRows(withLabelText: self.rowTitles[index]).first
        
        guard let labelString = row?.label as? String else {
            XCTFail("Label Title is not String.")
            return
        }
        XCTAssert(row != nil && labelString == self.rowTitles[index])
    }
    
    func testGetViewsShouldReturn() {
        let views = [UITextView(), UIImageView()]
        let form = self.makeMockFormWithRandomViews(views: views)
        let rows = form.getViews()
        XCTAssert(rows.count == views.count)
        XCTAssert(rows[0] is UITextView)
        XCTAssert(rows[1] is UIImageView)
    }
    
    func testGetViewsWithViewClassShouldReturn() {
        let btn = UIButton()
        let `switch` = UISwitch()
        let form = self.makeMockFormWithRandomViews(views: [btn, `switch`])
        let btnView = form.getViews(withViewClass: UIButton.self).first
        let switchView = form.getViews(withViewClass: UISwitch.self).first
        
        XCTAssert(btnView == btn && switchView == `switch`)
    }
    
    func testValidateRequiredViewWithValueShouldReturnTrue() {
        let row = PNPRow(config: PNPRowConfig(validation: .required))
        row.value = "Test"
        
        let form = PNPForm(rows: [row], separatorColor: .black)
        
        XCTAssert(form.validateRows() == true)
    }
    
    func testValidateRequiredViewWithoutValueShouldReturnFalse() {
        let row = PNPRow(config: PNPRowConfig(validation: .required))
        row.value = nil
        
        let form = PNPForm(rows: [row], separatorColor: .black)
        
        XCTAssert(form.validateRows() == false)
    }
}
