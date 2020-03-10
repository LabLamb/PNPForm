//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

class BaseFormRow: UIView {
    
    var labelView: UIView
    var valueView: UIView
    
    var desc: Any {
        get {
            return ""
        }
    }
    
    var value: String {
        get {
            return ""
        }
        
        set {
        }
    }
    
    var spacing: CGFloat
    
    init(labelView: UIView,
         valueView: UIView,
         spacing: CGFloat) {
        self.labelView = labelView
        self.valueView = valueView
        self.spacing = spacing
        
        super.init(frame: .zero)
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.focusValueView))
        self.labelView.gestureRecognizers?.append(tapGest)
        self.labelView.isUserInteractionEnabled = true
    }
    
    func setupLayout() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func focusValueView() {
        self.valueView.becomeFirstResponder()
    }
    
    @objc func unfocusValueView() {
        self.valueView.resignFirstResponder()
    }
    
}
