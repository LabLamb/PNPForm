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
                switch self.valueView {
                case is UITextField:
                    return (self.valueView as? UITextField)?.placeholder as Any
                case is UITextView:
                    return self.placeholderLabel?.text as Any
                default:
                    return ""
                }
            }
        }
        
        set {
            switch self.labelView {
            case is UILabel:
                (self.labelView as? UILabel)?.text = newValue as? String
            case is UIImageView:
                (self.labelView as? UIImageView)?.image = newValue as? UIImage
            default:
                switch self.valueView {
                case is UITextField:
                    (self.valueView as? UITextField)?.placeholder = newValue as? String
                case is UITextView:
                    self.placeholderLabel?.text = newValue as? String
                default:
                    break
                }
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
            case is UILabel:
                return (self.valueView as? UILabel)?.text
            case is UISegmentedControl:
                guard let seg = self.valueView as? UISegmentedControl else { return nil }
                let index = seg.selectedSegmentIndex
                return seg.titleForSegment(at: index)
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
            case is UILabel:
                (self.valueView as? UILabel)?.text = newValue
            case is UISegmentedControl:
                guard let seg = self.valueView as? UISegmentedControl else { return }
                let index = Int(newValue ?? "0") ?? 0
                seg.selectedSegmentIndex = index
            case is UISwitch:
                (self.valueView as? UISwitch)?.isOn = newValue?.boolValue ?? true
            default:
                break
            }
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: PNPFormConstants.UI.BaseRowDefaultHeight)
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
        
        var tempValueView: UIView
        var validationOption: ValidateOption? = config.validation
        var isSpaceType: Bool = false
        
        switch config.type {
        case .email:
            tempValueView = PNPTextField(placeholder: config.placeholder ?? "")
            if validationOption == nil {
                validationOption = .matchRegex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            }
            
        case .password(let keyboardConfig):
            let txtField = PNPTextField(placeholder: config.placeholder ?? "",
                                        keyboardConfig: keyboardConfig)
            txtField.isSecureTextEntry = true
            tempValueView = txtField
            
        case .singlelineText(let keyboardConfig):
            tempValueView = PNPTextField(placeholder: config.placeholder ?? "",
                                         keyboardConfig: keyboardConfig)
            
        case .multilineText(let keyboardConfig):
            tempValueView = PNPTextView(keyboardConfig: keyboardConfig)
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
            
        case .label:
            tempValueView = UILabel()
            
        case .date(let format):
            let dateView = PNPDateTimeField(placeholder: config.placeholder ?? "",
                                            datePickerMode: .date,
                                            dateTimeFormat: format)
            tempValueView = dateView
            
        case .time(let format):
            let dateView = PNPDateTimeField(placeholder: config.placeholder ?? "",
                                            datePickerMode: .time,
                                            dateTimeFormat: format)
            tempValueView = dateView
            
        case .dateAndTime(let format):
            let dateView = PNPDateTimeField(placeholder: config.placeholder ?? "",
                                            datePickerMode: .dateAndTime,
                                            dateTimeFormat: format)
            tempValueView = dateView
            
        case .switch:
            let switchView = UISwitch()
            switchView.isOn = config.placeholder?.boolValue ?? false
            tempValueView = switchView
            
        case .button(let target, let selector):
            let btn = UIButton()
            btn.setTitle(config.placeholder ?? "", for: .normal)
            btn.setTitleColor(.systemBlue, for: .normal)
            btn.addTarget(target, action: selector, for: .touchUpInside)
            tempValueView = btn
            
        case .segmentedControl(let list):
            let seg = UISegmentedControl(items: list)
            tempValueView = seg
            
        case .space(let color):
            isSpaceType = true
            tempValueView = UIView()
            tempValueView.backgroundColor = color
        }
        
        super.init(labelView: labelView,
                   valueView: tempValueView,
                   spacing: config.spacing,
                   labelWidth: config.labelWidth,
                   placeholder: placeholderLabel,
                   isSpace: isSpaceType,
                   validateOption: validationOption ?? .optional,
                   validatedHandling: config.validatedHandling)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
