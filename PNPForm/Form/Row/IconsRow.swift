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
        
        super.init(labelView: UILabel(),
                   valueView: textView,
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
