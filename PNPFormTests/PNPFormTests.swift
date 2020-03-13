//
//  Copyright © LabLambWorks. All rights reserved.
//

import XCTest
@testable import PNPForm

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
    
    func makeMockForm() -> Form {
        return PNPForm(rows: self.rowTitles.compactMap({ PNPRow(title: $0) }), separatorColor: .black)
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
        XCTAssert(form.getViews(withRowClass: UIApplicationDelegate.self) == [])
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
        let form = self.makeMockForm()
        let rows = form.getRows()
        for i in 0..<rows.count {
            XCTAssert(rows[i].label as? String == self.rowTitles[i]) // Check if they are the same rows
        }
        XCTAssert(form.getRows().count == self.rowTitles.count) // Check if the row number is the same
    }
}
