//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPDateTimeField: PNPTextField {
    
    let datePicker: UIDatePicker
    let dateFormat: String
    
    public init(placeholder: String = "",
                maxTextLength: Int = .max,
                datePickerMode: UIDatePicker.Mode,
                dateFormat: String = "yyyy-MM-dd") {
        self.datePicker = UIDatePicker()
        self.dateFormat = dateFormat
        super.init(placeholder: placeholder, maxTextLength: maxTextLength)
        self.datePicker.datePickerMode = datePickerMode
        self.inputView = self.datePicker
    }
    
    @objc func dateDidPick(){
        self.text = self.datePicker.date.toString(format: self.dateFormat)
        self.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
