////
////  Copyright © LabLambWorks. All rights reserved.
////
//
//import UIKit
//
//public final class Row: BaseRow {
//
//    override public var label: Any {
//        get {
//            return (self.labelView as? UILabel)?.text as Any
//        }
//
//        set {
//            (self.labelView as? UILabel)?.text = newValue as? String
//            self.setupLayout()
//        }
//    }
//
//    override public var value: String? {
//        get {
//            switch self.valueView {
//            case is UITextField:
//                return (self.valueView as? UITextField)?.text
//            case is UITextView:
//                return (self.valueView as? UITextView)?.text
//            default:
//                return nil
//            }
//        }
//
//        set {
//            switch self.valueView {
//            case is UITextField:
//                (self.valueView as? UITextField)?.text = newValue
//            case is UITextView:
//                self.placeholderLabel?.isHidden = newValue != ""
//                (self.valueView as? UITextView)?.text = newValue
//            default:
//                break
//            }
//        }
//    }
//
//    public convenience init(title:String, config: PNPRowConfig = PNPRowConfig()) {
//
//        let placeholderLabel: UILabel? = {
//            if let `placeholder` = config.placeholder {
//                let tempLabel = UILabel()
//                tempLabel.text = placeholder
//                return tempLabel
//            } else {
//                return nil
//            }
//        }()
//
//        switch config.type {
//        case .email:
//            self.init(title: title,
//                      with: PNPTextField(),
//                      spacing: config.spacing,
//                      labelWidth: config.labelWidth,
//                      placeholder: config.placeholder,
//                      validateOption: .matchRegex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"),
//                      validatedHandling: .default)
//        case .password:
//            let txtField = PNPTextField()
//            txtField.isSecureTextEntry = true
//            self.init(title: title,
//                      with: txtField,
//                      spacing: config.spacing,
//                      labelWidth: config.labelWidth,
//                      placeholder: config.placeholder,
//                      validateOption: .required,
//                      validatedHandling: .default)
//        case .singleLineText:
//            self.init(title: title,
//                      with: PNPTextField(),
//                      spacing: config.spacing,
//                      labelWidth: config.labelWidth,
//                      placeholder: config.placeholder,
//                      validateOption: config.validation,
//                      validatedHandling: config.validatedHandling)
//        case .multLineText:
//            self.init(title: title,
//                      with: PNPTextView(),
//                      spacing: config.spacing,
//                      labelWidth: config.labelWidth,
//                      placeholder: placeholderLabel,
//                      validateOption: config.validation,
//                      validatedHandling: config.validatedHandling)
//        case .switch:
//            self.init(title: title,
//                      with: UISwitch(),
//                      spacing: config.spacing,
//                      labelWidth: config.labelWidth,
//                      validateOption: config.validation,
//                      validatedHandling: config.validatedHandling)
//        }
//    }
//
//    private init(title: String,
//         with textField: UITextField,
//         spacing: CGFloat = 0,
//         labelWidth: CGFloat? = nil,
//         placeholder: String?,
//         validateOption: ValidateOption,
//         validatedHandling: ValidatedHandling) {
//        textField.placeholder = placeholder
//        super.init(labelView: UILabel(),
//                   valueView: textField,
//                   spacing: spacing,
//                   labelWidth: labelWidth,
//                   placeholder: nil,
//                   validateOption: validateOption,
//                   validatedHandling: validatedHandling)
//        self.label = title
//    }
//
//    private init(title: String,
//         with textView: UITextView,
//         spacing: CGFloat = 0,
//         labelWidth: CGFloat? = nil,
//         placeholder: UILabel?,
//         validateOption: ValidateOption,
//         validatedHandling: ValidatedHandling) {
//
//        textView.textContainer.heightTracksTextView = true
//        textView.textContainer.widthTracksTextView = false
//        textView.isScrollEnabled = false
//        textView.textContainer.lineFragmentPadding = 0
//        textView.font = UITextField().font
//        let inset = (PNPFormConstants.UI.BaseRowDefaultHeight - (UITextField().font?.lineHeight ?? 0)) / 2
//        textView.textContainerInset = .init(top: inset, left: 0, bottom: inset, right: 0)
//        textView.backgroundColor = .clear
//
//        placeholder?.font = UIFont.systemFont(ofSize: 17)
//        placeholder?.textColor = {
//            let tempUITextField = UITextField()
//            tempUITextField.placeholder = "temp"
//            let inspect = tempUITextField.attributedPlaceholder!
//            return inspect.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
//        }()
//
//        super.init(labelView: UILabel(),
//                   valueView: textView,
//                   spacing: spacing,
//                   labelWidth: labelWidth,
//                   placeholder: placeholder,
//                   validateOption: validateOption,
//                   validatedHandling: validatedHandling)
//        self.label = title
//    }
//
//    private init(title: String,
//         with switchView: UISwitch,
//         spacing: CGFloat = 0,
//         labelWidth: CGFloat? = nil,
//         validateOption: ValidateOption,
//         validatedHandling: ValidatedHandling) {
//        super.init(labelView: UILabel(),
//                   valueView: switchView,
//                   spacing: spacing,
//                   labelWidth: labelWidth,
//                   validateOption: validateOption,
//                   validatedHandling: validatedHandling)
//        self.label = title
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}