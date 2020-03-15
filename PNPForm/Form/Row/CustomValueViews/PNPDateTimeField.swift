//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPDateTimeField: PNPTextField {
    
    let datePicker: UIDatePicker
    let dateTimeFormat: String
    
    public init(placeholder: String = "",
                maxTextLength: Int = .max,
                datePickerMode: UIDatePicker.Mode,
                dateTimeFormat: String = "yyyy-MM-dd hh:mm") {
        self.datePicker = UIDatePicker()
        self.dateTimeFormat = dateTimeFormat
        super.init(placeholder: placeholder, maxTextLength: maxTextLength)
        self.datePicker.datePickerMode = datePickerMode
        self.datePicker.addTarget(self, action: #selector(self.dateDidPick), for: .valueChanged)
        self.inputView = self.datePicker
        self.endFloatingCursor()
    }
    
    @objc func dateDidPick(){
        self.text = self.datePicker.date.toString(format: self.dateTimeFormat)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
