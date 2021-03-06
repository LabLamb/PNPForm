//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

open class BaseRow: UIView {
    
    let labelView: UIView?
    
    let valueView: UIView
    let valueContainer: UIView
    
    open var label: Any {
        get {
            return ""
        }
        
        set {}
    }
    
    open var value: String? {
        get {
            return nil
        }
        
        set {}
    }
    
    let spacing: CGFloat
    let labelWidth: CGFloat?
    let placeholderLabel: UILabel?
    
    let isSpaceRow: Bool
    
    lazy var validationHighlight: UILabel = {
        let result = UILabel()
        result.textAlignment = .center
        result.text = "⚠️"
        result.isHidden = true
        return result
    }()
    
    var isShowingErrorIcon: Bool {
        get {
            return !self.validationHighlight.isHidden
        }
        
        set {
            self.validationHighlight.isHidden = !newValue
        }
    }
    
    private let validateLogic: ValidationLogic
    private var isValid: Bool {
        get {
            return self.validateLogic(self.value)
        }
    }
    
    private let validatedHandling: ValidatedHandling
    
    public init(labelView: UIView?,
         valueView: UIView,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil,
         placeholder: UILabel? = nil,
         isSpace: Bool = false,
         validateOption: ValidateOption,
         validatedHandling: ValidatedHandling) {
        
        self.labelView = labelView
        
        self.valueView = valueView
        self.valueContainer = UIView()
        
        self.spacing = spacing
        self.labelWidth = labelWidth
        
        self.placeholderLabel = placeholder
        
        self.isSpaceRow = isSpace
        
        self.validateLogic = { rowValue in
            switch validateOption {
                
            case .required:
                guard let rowString = rowValue else { return false }
                return rowString.count > 0
            case .optional:
                return true
                
            case .minimumCharacter(let min):
                guard let rowString = rowValue else { return false }
                return rowString.count >= min
                
            case .matchRegex(let pattern):
                guard let rowString = rowValue else { return false }
                let pred = NSPredicate(format:"SELF MATCHES %@", pattern)
                return pred.evaluate(with: rowString)
                
            case .customLogic(let logic):
                return logic(rowValue)
            }
        }
        
        self.validatedHandling = validatedHandling
        
        super.init(frame: .zero)
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.focusValueView))
        self.labelView?.addGestureRecognizer(tapGest)
        self.labelView?.isUserInteractionEnabled = true
        
        if let textView = valueView as? PNPTextView {
            textView.delegate = self
        }
        
        self.setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func validateRow() -> Bool {
        switch self.validatedHandling {
            
        case .default:
            PNPFormConstants.System.DefaultValidatedHandler(self, self.isValid)
            
        case .custom(let customHandler):
            customHandler(self, self.isValid)
            
        case .none:
            break
        }
        
        return self.isValid
    }
    
    @objc func focusValueView() {
        self.valueView.becomeFirstResponder()
    }
    
    @objc func unfocusValueView() {
        self.valueView.resignFirstResponder()
    }
    
}

extension BaseRow: CustomView {
    private func resetViews() {
        self.subviews.forEach({
            $0.removeConstraints($0.constraints)
            $0.removeFromSuperview()
        })
    }
    
    private func addLabelView(_ labelView: UIView) {
        self.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        let labelViewWidthConstraint: NSLayoutConstraint = {
            if let width = self.labelWidth {
                return labelView.widthAnchor.constraint(equalToConstant: width)
            } else {
                if labelView is UIImageView {
                    return labelView.widthAnchor.constraint(equalTo: labelView.heightAnchor)
                } else {
                    return labelView.widthAnchor.constraint(equalToConstant: labelView.intrinsicContentSize.width)
                }
            }
        }()
        NSLayoutConstraint.activate([
            labelView.leftAnchor.constraint(equalTo: self.leftAnchor),
            labelView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelView.heightAnchor.constraint(equalToConstant: PNPFormConstants.UI.RowIconDefaultHeight),
            labelViewWidthConstraint
        ])
    }
    
    private func addValidationHighlight() {
        self.addSubview(self.validationHighlight)
        self.validationHighlight.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.validationHighlight.heightAnchor.constraint(equalToConstant: self.validationHighlight.font.lineHeight),
            self.validationHighlight.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.validationHighlight.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.validationHighlight.widthAnchor.constraint(equalTo: self.validationHighlight.heightAnchor, multiplier: 1.25)
        ])
    }
    
    private func addValueViewContainer() {
        self.addSubview(self.valueContainer)
        self.valueContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let valueContainerLeftAnchorConstraint: NSLayoutConstraint = {
            if let `labelView` = self.labelView {
                return self.valueContainer.leftAnchor.constraint(equalTo: labelView.rightAnchor, constant: self.spacing)
            } else {
                return self.valueContainer.leftAnchor.constraint(equalTo: self.leftAnchor)
            }
        }()
        
        let valueContainerRightAnchorConstraint: NSLayoutConstraint = {
            if self.isSpaceRow {
                return self.valueContainer.rightAnchor.constraint(equalTo: self.rightAnchor)
            } else {
                return self.valueContainer.rightAnchor.constraint(equalTo: self.validationHighlight.leftAnchor)
            }
        }()
        
        NSLayoutConstraint.activate([
            valueContainerLeftAnchorConstraint,
            self.valueContainer.topAnchor.constraint(equalTo: self.topAnchor),
            self.valueContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            valueContainerRightAnchorConstraint
        ])
    }
    
    private func addPlaceholderLabel(_ placeholderLabel: UILabel) {
        self.addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: self.valueContainer.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.valueContainer.centerYAnchor),
            placeholderLabel.widthAnchor.constraint(equalTo: self.valueContainer.widthAnchor),
            placeholderLabel.heightAnchor.constraint(equalTo: self.valueContainer.heightAnchor)
        ])
    }
    
    private func addValueView() {
        self.addSubview(self.valueView)
        self.valueView.translatesAutoresizingMaskIntoConstraints = false
        let valueViewConstraints: [NSLayoutConstraint] = {
            var result = [NSLayoutConstraint]()
            switch self.valueView {
            case is UISwitch:
                result = [
                    self.valueView.rightAnchor.constraint(equalTo: self.valueContainer.rightAnchor),
                    self.valueView.centerYAnchor.constraint(equalTo: self.valueContainer.centerYAnchor)
                ]
            case is UISegmentedControl:
                if self.labelView == nil {
                    result = [
                        self.valueView.centerXAnchor.constraint(equalTo: self.valueContainer.centerXAnchor),
                        self.valueView.centerYAnchor.constraint(equalTo: self.valueContainer.centerYAnchor)
                    ]
                } else {
                    result = [
                        self.valueView.rightAnchor.constraint(equalTo: self.valueContainer.rightAnchor),
                        self.valueView.centerYAnchor.constraint(equalTo: self.valueContainer.centerYAnchor)
                    ]
                }
            case is UISlider:
                result = [
                    self.valueView.leftAnchor.constraint(equalTo: self.valueContainer.leftAnchor),
                    self.valueView.centerYAnchor.constraint(equalTo: self.valueContainer.centerYAnchor),
                    self.valueView.heightAnchor.constraint(equalToConstant: PNPFormConstants.UI.BaseRowDefaultHeight),
                    self.valueView.rightAnchor.constraint(equalTo: self.valueContainer.rightAnchor)
                ]
            default:
                result = [
                    self.valueView.leftAnchor.constraint(equalTo: self.valueContainer.leftAnchor),
                    self.valueView.topAnchor.constraint(equalTo: self.valueContainer.topAnchor),
                    self.valueView.bottomAnchor.constraint(equalTo: self.valueContainer.bottomAnchor),
                    self.valueView.rightAnchor.constraint(equalTo: self.valueContainer.rightAnchor)
                ]
            }
            return result
        }()
        NSLayoutConstraint.activate(valueViewConstraints)
    }
    
    @objc open func setupLayout() {
        self.resetViews()
        
        if let `labelView` = self.labelView,
            !self.isSpaceRow {
            self.addLabelView(labelView)
        }
        
        self.addValidationHighlight()
        self.addValueViewContainer()
        self.addValueView()
        
        if let `placeholderLabel` = self.placeholderLabel {
            self.addPlaceholderLabel(placeholderLabel)
        }
    }
}

extension BaseRow: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let isDeletingAll: Bool = (range.length == textView.text.count) && (text == "")
        self.placeholderLabel?.isHidden = !isDeletingAll
        return true
    }
}
