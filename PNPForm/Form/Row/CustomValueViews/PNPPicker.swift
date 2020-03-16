//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPPicker: PNPTextField {
    
    let picker: UIPickerView
    let values: [String]
    
    public init(placeholder: String = "",
                options: [String]) {
        self.picker = UIPickerView()
        self.values = options
        super.init(placeholder: placeholder)
        self.picker.delegate = self
        self.picker.dataSource = self
//        self.picker.addTarget(self, action: #selector(self.dateDidPick), for: .valueChanged)
        self.inputView = self.picker
//        self.endFloatingCursor()
    }
    
//    @objc func dateDidPick(){
//        self.text = self.picker.date.toString(format: self.dateTimeFormat)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PNPPicker: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = self.values[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.values[row]
    }
}

extension PNPPicker: UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.values.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
