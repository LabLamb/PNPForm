//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPPicker: UILabel {
    
    let picker: UIPickerView
    let values: [String]
    
    public init(placeholder: String = "",
                defaultRow: Int,
                options: [String]) {
        self.picker = UIPickerView()
        self.values = options
        super.init(frame: .zero)
        self.picker.delegate = self
        self.picker.dataSource = self
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.onTapped))
        self.addGestureRecognizer(tapGest)
        self.isUserInteractionEnabled = true
        
        self.picker.selectedRow(inComponent: defaultRow)
        self.text = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTapped() {
        self.picker.isHidden = false
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
