//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPRow: BaseRow {
    
    override public var label: Any {
        get {
            switch self.labelView {
            case is UILabel:
                return (self.labelView as? UILabel)?.text as Any
            case is UIImageView:
                return (self.labelView as? UIImageView)?.image as Any
            default:
                return self.placeholderLabel?.text as Any
            }
        }
        
        set {
            switch self.labelView {
            case is UILabel:
                (self.labelView as? UILabel)?.text = newValue as? String
            case is UIImageView:
                (self.labelView as? UIImageView)?.image = newValue as? UIImage
            default:
                break
            }
            self.setupLayout()
        }
    }
    
    override public var value: String? {
        get {
            switch self.valueView {
            case is UITextField:
                return (self.valueView as? UITextField)?.text
            case is UITextView:
                return (self.valueView as? UITextView)?.text
            case is UISwitch:
                return String((self.valueView as? UISwitch)?.isOn ?? false)
            default:
                return nil
            }
        }
        
        set {
            switch self.valueView {
            case is UITextField:
                (self.valueView as? UITextField)?.text = newValue
            case is UITextView:
                self.placeholderLabel?.isHidden = newValue != ""
                (self.valueView as? UITextView)?.text = newValue
            case is UISwitch:
                (self.valueView as? UISwitch)?.isOn = newValue?.boolValue ?? true
            default:
                break
            }
        }
    }
    
    public convenience init(config: PNPRowConfig = PNPRowConfig()) {
        self.init(labelView: nil, config: config)
    }
    
    public convenience init(title: String, config: PNPRowConfig = PNPRowConfig()) {
        self.init(labelView: UILabel(), config: config)
        self.label = title
    }
    
    public convenience init(icon: UIImage, config: PNPRowConfig = PNPRowConfig()) {
        self.init(labelView: UIImageView(), config: config)
        self.label = icon
    }
    
    private init(labelView: UIView?, config: PNPRowConfig) {
        
        var placeholderLabel: UILabel? = nil
        
        var valueView: UIView
        var validationOption: ValidateOption? = config.validation
        
        switch config.type {
        case .email:
            valueView = PNPTextField(placeholder: config.placeholder ?? "")
            if validationOption == nil {
                validationOption = .matchRegex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            }
            
        case .password:
            let txtField = PNPTextField(placeholder: config.placeholder ?? "")
            txtField.isSecureTextEntry = true
            valueView = txtField
            
        case .singleLineText:
            valueView = PNPTextField(placeholder: config.placeholder ?? "")
            
        case .multLineText:
            valueView = PNPTextView()
            placeholderLabel = {
                if let `placeholder` = config.placeholder {
                    let tempLabel = UILabel()
                    tempLabel.text = placeholder
                    return tempLabel
                } else {
                    return nil
                }
            }()
            placeholderLabel?.font = UIFont.systemFont(ofSize: 17)
            placeholderLabel?.textColor = {
                let tempUITextField = UITextField()
                tempUITextField.placeholder = "temp"
                let inspect = tempUITextField.attributedPlaceholder!
                return inspect.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
            }()
            
        case .switch:
            valueView = UISwitch()
        }
        
        super.init(labelView: labelView,
                   valueView: valueView,
                   spacing: config.spacing,
                   labelWidth: config.labelWidth,
                   placeholder: placeholderLabel,
                   validateOption: validationOption ?? .optional,
                   validatedHandling: config.validatedHandling)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
