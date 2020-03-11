//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

open class BaseFormRow: UIView {
    
    var labelView: UIView?
    var valueView: UIView
    
    public var label: Any {
        get {
            return ""
        }
        
        set {}
    }
    
    public var value: Any? {
        get {
            return nil
        }
        
        set {}
    }
    
    let spacing: CGFloat
    let labelWidth: CGFloat?
    let placeholderLabel: UILabel?
    
    private let validateLogic: ValidationLogic
    public var validStatus: Bool {
        get {
            return self.validateLogic(self)
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: PNPFormConstants.UI.BaseRowDefaultHeight)
    }
    
    init(labelView: UIView?,
         valueView: UIView,
         spacing: CGFloat = 0,
         labelWidth: CGFloat? = nil,
         placeholder: UILabel? = nil,
         validateOption: ValidateOption) {
        self.labelView = labelView
        self.valueView = valueView
        self.spacing = spacing
        self.labelWidth = labelWidth
        self.placeholderLabel = placeholder
        
        let handler: ValidationLogic = { row in
            switch validateOption {
            case .require:
                guard let rowString = row.value as? String else { return false }
                return rowString.count > 0
            case .optional:
                return true
            case .minimum(let min):
                guard let rowString = row.value as? String else { return false }
                return rowString.count >= min
            case .pattern(let pattern):
                guard let rowString = row.value as? String else { return false }
                let pred = NSPredicate(format:"SELF MATCHES %@", pattern.rawValue)
                return pred.evaluate(with: rowString)
            case .customPattern(let pattern):
                guard let rowString = row.value as? String else { return false }
                let pred = NSPredicate(format:"SELF MATCHES %@", pattern)
                return pred.evaluate(with: rowString)
            case .customLogic(let logic):
                return logic(row)
            }
        }
        
        self.validateLogic = handler
        
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
    
    @objc func focusValueView() {
        self.valueView.becomeFirstResponder()
    }
    
    @objc func unfocusValueView() {
        self.valueView.resignFirstResponder()
    }
    
}

extension BaseFormRow: CustomView {
    @objc func setupLayout() {
        self.subviews.forEach({
            $0.removeConstraints($0.constraints)
            $0.removeFromSuperview()
        })

        if let `labelView` = self.labelView {
            self.addSubview(labelView)
            labelView.translatesAutoresizingMaskIntoConstraints = false
            let labeViewWidthConstraint: NSLayoutConstraint = {
                if let width = self.labelWidth {
                    return labelView.widthAnchor.constraint(equalToConstant: width)
                } else {
                    return labelView.widthAnchor.constraint(equalToConstant: labelView.intrinsicContentSize.width)
                }
            }()
            [
                labelView.leftAnchor.constraint(equalTo: self.leftAnchor),
                labelView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                labelView.heightAnchor.constraint(equalToConstant: PNPFormConstants.UI.BaseRowDefaultHeight),
                labeViewWidthConstraint
            ].forEach({ $0.isActive = true })
        }
        
        self.addSubview(self.valueView)
        self.valueView.translatesAutoresizingMaskIntoConstraints = false
        let valueViewLeftAnchorConstraint: NSLayoutConstraint = {
            if let `labelView` = self.labelView {
                return self.valueView.leftAnchor.constraint(equalTo: labelView.rightAnchor, constant: self.spacing)
            } else {
                return self.valueView.leftAnchor.constraint(equalTo: self.leftAnchor)
            }
        }()
        [
            valueViewLeftAnchorConstraint,
            self.valueView.topAnchor.constraint(equalTo: self.topAnchor),
            self.valueView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.valueView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ].forEach({ $0.isActive = true })
        
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

extension BaseFormRow: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let isDeletingAll: Bool = (range.length == textView.text.count) && (text == "")
        self.placeholderLabel?.isHidden = !isDeletingAll
        return true
    }
}
