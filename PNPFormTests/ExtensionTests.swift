//
//  Copyright © LabLambWorks. All rights reserved.
//

import XCTest
@testable import PNPForm

class ExtensionTests: XCTestCase {
    
    func testDateStringValidFormat() {
        let format = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateObj = dateFormatter.date(from: "2000-01-01")
        
        let dateString = dateObj?.toString(format: format)
        XCTAssert(dateString == "2000-01-01")
    }
    
    func testDateStringInvalidFormatCharacters() {
        let format = "ppppp"
        let dateObj = Date()
        let dateString = dateObj.toString(format: format)
        print(dateString)
        XCTAssert(dateString == "")
    }
    
    func testDateStringInvalidFormatSymbols() {
        let format = "%@$^&*(#("
        let dateObj = Date()
        let dateString = dateObj.toString(format: format)
        print(dateString)
        XCTAssert(dateString == format)
    }
    
    func testStringShouldReturnBoolCorrectlyTrue() {
        let testString = "true"
        XCTAssertTrue(testString.lowercased().boolValue && testString.uppercased().boolValue && testString.capitalized.boolValue)
    }
    
    func testStringShouldReturnBoolCorrectlyY() {
        let testString = "Y"
        XCTAssertTrue(testString.lowercased().boolValue && testString.uppercased().boolValue)
    }
    
    func testStringShouldReturnBoolCorrectlyYes() {
        let testString = "Yes"
        XCTAssertTrue(testString.lowercased().boolValue && testString.uppercased().boolValue && testString.capitalized.boolValue)
    }
    
    func testStringShouldReturnBoolCorrectlyT() {
        let testString = "T"
        XCTAssertTrue(testString.lowercased().boolValue && testString.uppercased().boolValue)
    }
    
    func testStringShouldReturnBoolCorrectlyOneToNine() {
        let testString = "1"
        XCTAssertTrue(testString.boolValue)
    }
    
    func testStringShouldReturnBoolCorrectlyFalse() {
        let testString = "false"
        XCTAssertTrue(!testString.lowercased().boolValue && !testString.uppercased().boolValue && !testString.capitalized.boolValue)
    }
    
    func testStringShouldReturnBoolCorrectlyN() {
        let testString = "N"
        XCTAssertTrue(!testString.lowercased().boolValue && !testString.uppercased().boolValue)
    }
    
    func testStringShouldReturnBoolCorrectlyNo() {
        let testString = "No"
        XCTAssertTrue(!testString.lowercased().boolValue && !testString.uppercased().boolValue && !testString.capitalized.boolValue)
    }
    
    func testStringShouldReturnBOolCorrectlyZero() {
        let testString = "0"
        XCTAssertTrue(!testString.boolValue)
    }
    
}
