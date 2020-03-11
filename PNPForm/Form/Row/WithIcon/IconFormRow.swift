//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class IconsFormRow: BaseFormRow {
    
    override var label: Any {
        get {
            return (self.labelView as? UIImageView)?.image as Any
        }
        
        set {
            (self.labelView as? UIImageView)?.image = newValue as? UIImage
            self.setupLayout()
        }
    }
    
    override var value: Any? {
        get {
            switch self.valueView {
            case is UITextField:
                return (self.valueView as? UITextField)?.text
            case is UITextView:
                return (self.valueView as? UITextView)?.text
            default:
                return nil
            }
        }
        
        set {
            switch self.valueView {
            case is UITextField:
                (self.valueView as? UITextField)?.text = newValue as? String
            case is UITextView:
                (self.valueView as? UITextView)?.text = newValue as? String
            default:
                break
            }
        }
    }
    
    private let icon: UIImage
    
    public init(icon: UIImage,
         with textField: UITextField,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil) {
        self.icon = icon
        super.init(labelView: UILabel(), valueView: textField, spacing: spacing, labelWidth: labelWidth)
        self.label = icon
    }
    
    public init(icon: UIImage,
         with textView: UITextView,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil) {
        self.icon = icon
        super.init(labelView: UILabel(), valueView: textView, spacing: spacing, labelWidth: labelWidth)
        self.label = icon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        if let `placeholderLabel` = self.placeholderLabel {
            self.addSubview(placeholderLabel)
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            [
                placeholderLabel.centerXAnchor.constraint(equalTo: self.valueView.centerXAnchor),
                placeholderLabel.centerYAnchor.constraint(equalTo: self.valueView.centerYAnchor),
                placeholderLabel.widthAnchor.constraint(equalTo: self.valueView.widthAnchor),
                placeholderLabel.heightAnchor.constraint(equalTo: self.valueView.heightAnchor)
            ].forEach({ $0.isActive = true })
        }
    }
}
