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
    
    func test_getRows_should_return_empty_if_no_rows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.getRows() == [])
    }
    
    func test_getRowsWithLabelIcon_should_return_empty_if_no_rows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.getRows(withLabelIcon: rowIcons[0]) == [])
    }
    
    func test_getRowsWithLabelText_should_return_empty_if_no_rows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.getRows(withLabelText: rowTitles[0]) == [])
    }
    
    func test_getViewsWithRowClass_should_return_empty_if_no_rows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.getViews(withViewClass: UIApplicationDelegate.self) == [])
    }
    
    func test_extractRowValuesInOrder_should_return_empty_if_no_rows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.extractRowValuesInOrder() == [])
    }
    
    func test_extractRowValuesWithLabelTextList_should_return_empty_if_no_rows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.extractRowValues(withLabelTextList: self.rowTitles) == [:])
    }
    
    func test_extractRowValuesWithLabelIconList_should_return_empty_if_no_rows() {
        let form = PNPForm(rows: [], separatorColor: .black)
        XCTAssert(form.extractRowValues(withLabelIconList: self.rowIcons) == [:])
    }
    
    func test_getRows_should_return_all_rows() {
        let form = self.makeMockFormWithTitles()
        let rows = form.getRows()
        for i in 0..<rows.count {
            XCTAssert(rows[i].label as? String == self.rowTitles[i])
        }
        XCTAssert(form.getRows().count == self.rowTitles.count)
    }
    
    func test_getRowsWithLabelIcon_should_return() {
        let index = 0
        let form = self.makeMockFormWithIcons()
        let row = form.getRows(withLabelIcon: self.rowIcons[index]).first
        
        guard let labelIcon = row?.label as? UIImage else {
            XCTFail("Label Icon is not an UIImage.")
            return
        }
        XCTAssert(row != nil && labelIcon == self.rowIcons[index])
    }
    
    func test_getRowsWithLabelTitle_should_return() {
        let index = 0
        let form = self.makeMockFormWithTitles()
        let row = form.getRows(withLabelText: self.rowTitles[index]).first
        
        guard let labelString = row?.label as? String else {
            XCTFail("Label Title is not String.")
            return
        }
        XCTAssert(row != nil && labelString == self.rowTitles[index])
    }
    
    func test_getViews_should_return() {
        let views = [UITextView(), UIImageView()]
        let form = self.makeMockFormWithRandomViews(views: views)
        let rows = form.getViews()
        XCTAssert(rows.count == views.count)
        XCTAssert(rows[0] is UITextView)
        XCTAssert(rows[1] is UIImageView)
    }
    
    func test_getViewsWithViewClass_should_return() {
        let btn = UIButton()
        let `switch` = UISwitch()
        let form = self.makeMockFormWithRandomViews(views: [btn, `switch`])
        let btnView = form.getViews(withViewClass: UIButton.self).first
        let switchView = form.getViews(withViewClass: UISwitch.self).first
        
        XCTAssert(btnView == btn && switchView == `switch`)
    }
    
    func test_validateRows_should_return_true_if_required_and_not_empty() {
        let row = PNPRow(config: PNPRowConfig(validation: .required))
        row.value = "Some Value"
        
        let form = PNPForm(rows: [row], separatorColor: .black)
        
        XCTAssert(form.validateRows() == true)
    }
    
    func test_validateRows_should_return_false_if_required_and_empty() {
        let row = PNPRow(config: PNPRowConfig(validation: .required))
        row.value = nil
        
        let form = PNPForm(rows: [row], separatorColor: .black)
        
        XCTAssert(form.validateRows() == false)
    }
    
    func test_prefillRowsInOrder_should_equal() {
        let row1 = PNPRow()
        let row2 = PNPRow()
        let row3 = PNPRow()
        
        let form = PNPForm(rows: [row1, row2, row3], separatorColor: .black)
        form.prefillRowsInOrder(orderedValues: self.rowValues)
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsInOrder_should_not_equal() {
        let row1 = PNPRow()
        let row2 = PNPRow()
        let row3 = PNPRow()
        
        let form = PNPForm(rows: [row2, row3, row1], separatorColor: .black)
        form.prefillRowsInOrder(orderedValues: self.rowValues)
        
        XCTAssert(row1.value != self.rowValues[0])
        XCTAssert(row2.value != self.rowValues[1])
        XCTAssert(row3.value != self.rowValues[2])
    }
    
    func test_prefillRowsInOrder_should_skip_non_BaseRow() {
        let values = [
            "Value 1",
            "Value 2",
            "Value 3",
            "Value 4"
        ]
        
        let row1 = PNPRow()
        let row2 = PNPRow()
        let row3 = PNPRow()
        let row4 = UIView()
        let row5 = PNPRow()
        
        let form = PNPForm(rows: [row1, row2, row3, row4, row5], separatorColor: .black)
        form.prefillRowsInOrder(orderedValues: values)
        
        XCTAssert(row1.value == values[0])
        XCTAssert(row2.value == values[1])
        XCTAssert(row3.value == values[2])
        XCTAssert(row5.value == values[3])
    }
    
    func test_prefillRowsInOrder_should_not_crash_if_values_more_than_rows() {
        let values = [
            "Value 1",
            "Value 2",
            "Value 3",
            "Value 4",
            "Value 5",
            "Value 6"
        ]
        
        let row1 = PNPRow()
        
        let form = PNPForm(rows: [row1], separatorColor: .black)
        form.prefillRowsInOrder(orderedValues: values)
        
        XCTAssert(row1.value == values[0])
    }
    
    func test_prefillRowsInOrder_should_not_crash_if_rows_more_than_values() {
        let values = [
            "Value 1"
        ]
        
        let row1 = PNPRow()
        let row2 = PNPRow()
        
        let form = PNPForm(rows: [row1, row2], separatorColor: .black)
        form.prefillRowsInOrder(orderedValues: values)
        
        XCTAssert(row1.value == values[0])
        XCTAssert(row2.value == "")
    }
    
    func test_prefillRowsTitleValueMap_should_equal() {
        let row1 = PNPRow(title: self.rowTitles[0])
        let row2 = PNPRow(title: self.rowTitles[1])
        let row3 = PNPRow(title: self.rowTitles[2])
        
        let form = PNPForm(rows: [row1, row2, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0],
            self.rowTitles[1]: self.rowValues[1],
            self.rowTitles[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsTitleValueMap_should_equal_if_shuffled() {
        let row1 = PNPRow(title: self.rowTitles[0])
        let row2 = PNPRow(title: self.rowTitles[1])
        let row3 = PNPRow(title: self.rowTitles[2])
        
        let form = PNPForm(rows: [row2, row1, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0],
            self.rowTitles[1]: self.rowValues[1],
            self.rowTitles[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsTitleValueMap_should_equal_if_have_random_view() {
        let row1 = PNPRow(title: self.rowTitles[0])
        let row2 = PNPRow(title: self.rowTitles[1])
        let row3 = PNPRow(title: self.rowTitles[2])
        
        let form = PNPForm(rows: [row2, UISegmentedControl(), row1, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0],
            self.rowTitles[1]: self.rowValues[1],
            self.rowTitles[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsTitleValueMap_should_equal_if_random_pair_in_map() {
        let row1 = PNPRow(title: self.rowTitles[0])
        let row2 = PNPRow(title: self.rowTitles[1])
        let row3 = PNPRow(title: self.rowTitles[2])
        
        let form = PNPForm(rows: [row2, UISegmentedControl(), row1, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0],
            self.rowTitles[1]: self.rowValues[1],
            self.rowTitles[2]: self.rowValues[2],
            "randomTitle": "randomValue"
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsTitleValueMap_should_equal_if_map_pair_less_than_rows() {
        let row1 = PNPRow(title: self.rowTitles[0])
        let row2 = PNPRow(title: self.rowTitles[1])
        let row3 = PNPRow(title: self.rowTitles[2])
        
        let form = PNPForm(rows: [row2, row1, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == "")
        XCTAssert(row3.value == "")
    }
    
    func test_prefillRowsTitleValueMap_with_no_label_should_equal() {
        let row1 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[0]))
        let row2 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[1]))
        let row3 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[2]))
        
        let form = PNPForm(rows: [row1, row2, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0],
            self.rowTitles[1]: self.rowValues[1],
            self.rowTitles[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsTitleValueMap_with_no_label_should_equal_if_shuffled() {
        let row1 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[0]))
        let row2 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[1]))
        let row3 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[2]))
        
        let form = PNPForm(rows: [row2, row1, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0],
            self.rowTitles[1]: self.rowValues[1],
            self.rowTitles[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsTitleValueMap_with_no_label_should_equal_if_have_random_view() {
        let row1 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[0]))
        let row2 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[1]))
        let row3 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[2]))
        
        let form = PNPForm(rows: [row2, UISegmentedControl(), row1, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0],
            self.rowTitles[1]: self.rowValues[1],
            self.rowTitles[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsTitleValueMap_with_no_label_should_equal_if_random_pair_in_map() {
        let row1 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[0]))
        let row2 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[1]))
        let row3 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[2]))
        
        let form = PNPForm(rows: [row2, UISegmentedControl(), row1, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0],
            self.rowTitles[1]: self.rowValues[1],
            self.rowTitles[2]: self.rowValues[2],
            "randomTitle": "randomValue"
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsTitleValueMap_with_no_label_should_equal_if_map_pair_less_than_rows() {
        let row1 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[0]))
        let row2 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[1]))
        let row3 = PNPRow(config: PNPRowConfig(placeholder: self.rowTitles[2]))
        
        let form = PNPForm(rows: [row2, row1, row3], separatorColor: .black)
        form.prefillRows(titleValueMap: [
            self.rowTitles[0]: self.rowValues[0]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == "")
        XCTAssert(row3.value == "")
    }
    
    func test_prefillRowsIconValueMap_should_equal() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        let row2 = PNPRow(icon: self.rowIcons[1])
        let row3 = PNPRow(icon: self.rowIcons[2])
        
        let form = PNPForm(rows: [row1, row2, row3], separatorColor: .black)
        form.prefillRows(iconValueMap: [
            self.rowIcons[0]: self.rowValues[0],
            self.rowIcons[1]: self.rowValues[1],
            self.rowIcons[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsIconValueMap_should_equal_if_shuffled() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        let row2 = PNPRow(icon: self.rowIcons[1])
        let row3 = PNPRow(icon: self.rowIcons[2])
        
        let form = PNPForm(rows: [row2, row1, row3], separatorColor: .black)
        form.prefillRows(iconValueMap: [
            self.rowIcons[0]: self.rowValues[0],
            self.rowIcons[1]: self.rowValues[1],
            self.rowIcons[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsIconValueMap_should_equal_if_have_random_view() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        let row2 = PNPRow(icon: self.rowIcons[1])
        let row3 = PNPRow(icon: self.rowIcons[2])
        
        let form = PNPForm(rows: [row2, UISegmentedControl(), row1, row3], separatorColor: .black)
        form.prefillRows(iconValueMap: [
            self.rowIcons[0]: self.rowValues[0],
            self.rowIcons[1]: self.rowValues[1],
            self.rowIcons[2]: self.rowValues[2]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsIconValueMap_should_equal_if_random_pair_in_map() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        let row2 = PNPRow(icon: self.rowIcons[1])
        let row3 = PNPRow(icon: self.rowIcons[2])
        
        let form = PNPForm(rows: [row2, UISegmentedControl(), row1, row3], separatorColor: .black)
        form.prefillRows(iconValueMap: [
            self.rowIcons[0]: self.rowValues[0],
            self.rowIcons[1]: self.rowValues[1],
            self.rowIcons[2]: self.rowValues[2],
            UIImage(): "randomValue"
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == self.rowValues[1])
        XCTAssert(row3.value == self.rowValues[2])
    }
    
    func test_prefillRowsIconValueMap_should_equal_if_map_pair_less_than_rows() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        let row2 = PNPRow(icon: self.rowIcons[1])
        let row3 = PNPRow(icon: self.rowIcons[2])
        
        let form = PNPForm(rows: [row2, row1, row3], separatorColor: .black)
        form.prefillRows(iconValueMap: [
            self.rowIcons[0]: self.rowValues[0]
        ])
        
        XCTAssert(row1.value == self.rowValues[0])
        XCTAssert(row2.value == "")
        XCTAssert(row3.value == "")
    }
    
    func test_extractRowValuesInOrder_should_equal() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(title: self.rowTitles[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow()
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row1, row2, row3], separatorColor: .black)
        let values = form.extractRowValuesInOrder()
        XCTAssert(row1.value == values[0])
        XCTAssert(row2.value == values[1])
        XCTAssert(row3.value == values[2])
    }
    
    func test_extractRowValuesInOrder_should_not_equal_if_shuffle() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(title: self.rowTitles[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow()
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row3, row1, row2], separatorColor: .black)
        let values = form.extractRowValuesInOrder()
        XCTAssert(row1.value != values[0])
        XCTAssert(row2.value != values[1])
        XCTAssert(row3.value != values[2])
    }
    
    func test_extractRowValuesInOrder_should_equal_if_non_BaseRow_in_between() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(title: self.rowTitles[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow()
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row1, row2, UIView(), UIButton(), row3], separatorColor: .black)
        let values = form.extractRowValuesInOrder()
        XCTAssert(row1.value == values[0])
        XCTAssert(row2.value == values[1])
        XCTAssert(row3.value == values[2])
    }
    
    func test_extractRowValuesWithLabelTextList_should_equal() {
        let row1 = PNPRow(title: self.rowTitles[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(title: self.rowTitles[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow(title: self.rowTitles[2])
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row1, row2, UIView(), UIButton(), row3], separatorColor: .black)
        let values = form.extractRowValues(withLabelTextList: self.rowTitles)
        XCTAssert(row1.value == values[self.rowTitles[0]])
        XCTAssert(row2.value == values[self.rowTitles[1]])
        XCTAssert(row3.value == values[self.rowTitles[2]])
    }
    
    func test_extractRowValuesWithLabelTextList_should_equal_if_shuffle() {
        let row1 = PNPRow(title: self.rowTitles[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(title: self.rowTitles[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow(title: self.rowTitles[2])
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row2, row1, row3], separatorColor: .black)
        let values = form.extractRowValues(withLabelTextList: self.rowTitles)
        XCTAssert(row1.value == values[self.rowTitles[0]])
        XCTAssert(row2.value == values[self.rowTitles[1]])
        XCTAssert(row3.value == values[self.rowTitles[2]])
    }
    
    func test_extractRowValuesWithLabelTextList_should_equal_if_non_BaseRow_in_between() {
        let row1 = PNPRow(title: self.rowTitles[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(title: self.rowTitles[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow(title: self.rowTitles[2])
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row2, row1, UIView(), UISegmentedControl(), row3, UITableView()], separatorColor: .black)
        let values = form.extractRowValues(withLabelTextList: self.rowTitles)
        XCTAssert(row1.value == values[self.rowTitles[0]])
        XCTAssert(row2.value == values[self.rowTitles[1]])
        XCTAssert(row3.value == values[self.rowTitles[2]])
    }
    
    func test_extractRowValuesWithLabelIconList_should_equal() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(icon: self.rowIcons[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow(icon: self.rowIcons[2])
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row1, row2, UIView(), UIButton(), row3], separatorColor: .black)
        let values = form.extractRowValues(withLabelIconList: self.rowIcons)
        XCTAssert(row1.value == values[self.rowIcons[0]])
        XCTAssert(row2.value == values[self.rowIcons[1]])
        XCTAssert(row3.value == values[self.rowIcons[2]])
    }
    
    func test_extractRowValuesWithLabelIconList_should_equal_if_shuffle() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(icon: self.rowIcons[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow(icon: self.rowIcons[2])
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row2, row1, row3], separatorColor: .black)
        let values = form.extractRowValues(withLabelIconList: self.rowIcons)
        XCTAssert(row1.value == values[self.rowIcons[0]])
        XCTAssert(row2.value == values[self.rowIcons[1]])
        XCTAssert(row3.value == values[self.rowIcons[2]])
    }
    
    func test_extractRowValuesWithLabelIconList_should_equal_if_non_BaseRow_in_between() {
        let row1 = PNPRow(icon: self.rowIcons[0])
        row1.value = self.rowValues[0]
        
        let row2 = PNPRow(icon: self.rowIcons[1])
        row2.value = self.rowValues[1]
        
        let row3 = PNPRow(icon: self.rowIcons[2])
        row3.value = self.rowValues[2]
        
        let form = PNPForm(rows: [row2, row1, UIView(), UISegmentedControl(), row3, UITableView()], separatorColor: .black)
        let values = form.extractRowValues(withLabelIconList: self.rowIcons)
        XCTAssert(row1.value == values[self.rowIcons[0]])
        XCTAssert(row2.value == values[self.rowIcons[1]])
        XCTAssert(row3.value == values[self.rowIcons[2]])
    }
    
    func test_appendView_with_BaseRow_should_exists() {
        let form = self.makeMockFormWithTitles()
        
        let rowCountBeforeAppend = form.getRows().count
        
        let row = PNPRow()
        
        form.appendView(view: row)
        
        let rowCountAfterAppend = form.getRows().count
        
        XCTAssert(rowCountAfterAppend > rowCountBeforeAppend)
    }
}
