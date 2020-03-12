//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class IconsRow: BaseRow {
    
    override public var label: Any {
        get {
            return (self.labelView as? UIImageView)?.image as Any
        }
        
        set {
            (self.labelView as? UIImageView)?.image = newValue as? UIImage
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
            default:
                return nil
            }
        }
        
        set {
            switch self.valueView {
            case is UITextField:
                (self.valueView as? UITextField)?.text = newValue
            case is UITextView:
                (self.valueView as? UITextView)?.text = newValue
            default:
                break
            }
        }
    }
    
    public convenience init(icon: UIImage,
                            config: PNPRowConfig) {
        switch config.type {
        case .singleLineText:
            self.init(icon: icon,
                      with: UITextField(),
                      spacing: config.spacing,
                      labelWidth: config.labelWidth,
                      validateOption: config.validation,
                      validatedHandling: config.validatedHandling)
        case .multLineText:
            self.init(icon: icon,
                      with: PNPTextView(placeholder: ""),
                      spacing: config.spacing,
                      labelWidth: config.labelWidth,
                      validateOption: config.validation,
                      validatedHandling: config.validatedHandling)
        case .switch:
            self.init(icon: icon,
                      with: UISwitch(),
                      spacing: config.spacing,
                      labelWidth: config.labelWidth,
                      validateOption: config.validation,
                      validatedHandling: config.validatedHandling)
        }
    }
    
    private init(icon: UIImage,
         with textField: UITextField,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil,
         validateOption: ValidateOption,
         validatedHandling: ValidatedHandling) {
        
        super.init(labelView: UILabel(),
                   valueView: textField,
                   spacing: spacing,
                   labelWidth: labelWidth,
                   validateOption: validateOption,
                   validatedHandling: validatedHandling)
        
        self.label = icon
    }
    
    private init(icon: UIImage,
         with textView: UITextView,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil,
         validateOption: ValidateOption,
         validatedHandling: ValidatedHandling) {
        
        textView.textContainer.heightTracksTextView = true
        textView.textContainer.widthTracksTextView = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.font = UITextField().font
        let inset = (PNPFormConstants.UI.BaseRowDefaultHeight - (UITextField().font?.lineHeight ?? 0)) / 2
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
        
        super.init(labelView: UILabel(),
                   valueView: textView,
                   spacing: spacing,
                   labelWidth: labelWidth,
                   placeholder: tempPlaceholderLabel,
                   validateOption: validateOption,
                   validatedHandling: validatedHandling)
        self.label = icon
    }
    
    private init(icon: UIImage,
         with switchView: UISwitch,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil,
         validateOption: ValidateOption,
         validatedHandling: ValidatedHandling) {
        
        super.init(labelView: UILabel(),
                   valueView: switchView,
                   spacing: spacing,
                   labelWidth: labelWidth,
                   validateOption: validateOption,
                   validatedHandling: validatedHandling)
        
        self.label = icon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setupLayout() {
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
