//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPForm: UIView {
    
    private let stackView: UIStackView
    let formRows: [BaseRow]
    let separatorColor: UIColor
    let forceDefaultHeight: Bool
    
    public init(rows: [UIView],
         separatorColor: UIColor,
         forceDefaultHeight: Bool = true) {
        self.stackView = UIStackView()
        self.formRows = rows.filter({ $0 is BaseRow }) as! [BaseRow]
        self.separatorColor = separatorColor
        self.forceDefaultHeight = forceDefaultHeight
        
        super.init(frame: .zero)
        
        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        self.stackView.alignment = .center
        self.stackView.spacing = 1
        
        rows.forEach({ row in
            self.stackView.addArrangedSubview(row)
        })
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PNPForm: CustomView {
    func setupLayout() {
        self.addLine(position: .minYEdge, color: self.separatorColor, weight: 1.0)
        self.addLine(position: .maxYEdge, color: self.separatorColor, weight: 1.0)
        
        self.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        [
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ].forEach({ $0.isActive = true })
        
        self.stackView.arrangedSubviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            [
                view.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
                view.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.95)
            ].forEach({ $0.isActive = true })
            
            if self.forceDefaultHeight && (view is CustomView) == false {
                view.heightAnchor.constraint(equalToConstant: PNPFormConstants.UI.BaseRowDefaultHeight).isActive = true
            }
            
            view.backgroundColor = .clear
            view.addLine(position: .maxYEdge, color: self.separatorColor, weight: 1)
        }
    }
}

extension PNPForm: Form {
    public func getRows(withLabelIcon labelIcon: UIImage) -> [BaseRow] {
        return self.formRows.filter({ view in
            (view.label as? UIImage) == labelIcon
        })
    }
    
    public func getRows(withLabelText labelText: String) -> [BaseRow] {
        return self.formRows.filter({ view in
            (view.label as? String) == labelText
        })
    }
    
    public func getViews(withRowClass rowClass: AnyClass) -> [UIView] {
        return self.formRows.filter({ view in
            type(of: view) == rowClass
        })
    }
    
    public func prefillRows(values: [String: String]) {
        self.formRows.forEach({ row in
            if let label = row.label as? String, let value = values[label] {
                row.value = value
            }
        })
    }
    
    public func validateRows() {
        self.formRows.forEach({ $0.validateRow() })
    }
    
    public func extractRowValues() -> [String] {
        var result = [String]()
        self.formRows.forEach({ row in
            if let val = row.value {
                result.append(val)
            }
        })
        return result
    }
    
    public func extractRowValues(withLabelTextList list: [String]) -> [String: String] {
        var result: [String: String] = [:]
        self.formRows.forEach({ row in
            if let desc = row.label as? String,
                list.contains(desc) {
                result[desc] = row.value
            }
        })
        return result
    }
}
