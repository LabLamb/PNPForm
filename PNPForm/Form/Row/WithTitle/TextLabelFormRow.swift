//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class TextLabelFormRow: BaseFormRow {
    
    override var label: Any {
        get {
            return (self.labelView as? UILabel)?.text as Any
        }
        
        set {
            (self.labelView as? UILabel)?.text = newValue as? String
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
                self.placeholderLabel?.isHidden = (newValue as? String) != ""
                (self.valueView as? UITextView)?.text = newValue as? String
            default:
                break
            }
        }
    }
    
    public convenience init(config: PNPRowConfiguration) {
        switch config.type {
        case .singleLineText:
            self.init(title: config.title, with: UITextField(), spacing: config.spacing, labelWidth: config.labelWidth)
        case .multLineText:
            self.init(title: config.title, with: PNPTextView(placeholder: ""), spacing: config.spacing, labelWidth: config.labelWidth)
        }
    }
    
    public init(title: String,
         with textField: UITextField,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil) {
        super.init(labelView: UILabel(), valueView: textField, spacing: spacing, labelWidth: labelWidth)
        self.label = title
    }
    
    public init(title: String,
         with textView: UITextView,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil) {
        
        textView.textContainer.heightTracksTextView = true
        textView.textContainer.widthTracksTextView = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.font = UITextField().font
        let inset = (Constants.UI.BaseRowDefaultHeight - (UITextField().font?.lineHeight ?? 0)) / 2
        textView.textContainerInset = .init(top: inset, left: 0, bottom: inset, right: 0)
        textView.backgroundColor = .clear
        
        let placeholderText: String = {
            if let `textView` = textView as? PNPTextView {
                return textView.placeholder
            } else {
                return ""
            }
        }()
        
        let tempPlaceholderLabel: UILabel = {
            let result = UILabel()
            result.text = placeholderText
            result.textColor = {
                let tempUITextField = UITextField()
                tempUITextField.placeholder = "temp"
                let inspect = tempUITextField.attributedPlaceholder!
                return inspect.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
            }()
            result.textAlignment = .left
            result.font = UIFont.systemFont(ofSize: 17)
            result.backgroundColor = .clear
            return result
        }()
        
        super.init(labelView: UILabel(), valueView: textView, spacing: spacing, labelWidth: labelWidth, placeholder: tempPlaceholderLabel)
        self.label = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
