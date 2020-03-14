//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

public final class PNPForm: UIView {
    
    private let stackView: UIStackView
    private let formRows: [BaseRow]
    private let separatorColor: UIColor
    
    public init(rows: [UIView],
                separatorColor: UIColor) {
        self.stackView = UIStackView()
        self.formRows = rows.filter({ $0 is BaseRow }) as! [BaseRow]
        self.separatorColor = separatorColor
        
        super.init(frame: .zero)
        
        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        self.stackView.alignment = .center
        
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
    private func setupRowConstraint(_ view: UIView) {
        var multipler: CGFloat = 0.95
        
        if let row = view as? PNPRow,
            row.isSpaceRow {
            multipler = 1
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        [
            view.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
            view.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: multipler)
        ].forEach({ $0.isActive = true })
    }
    
    private func redrawBorder () {
        for i in 0..<self.stackView.arrangedSubviews.count {
            if i > 0 {
                let previousView = self.stackView.arrangedSubviews[i - 1]
                let currentView = self.stackView.arrangedSubviews[i]
                currentView.subviews.filter({ $0 is UILine }).forEach({ $0.removeFromSuperview() })
                
                if let cv = currentView as? BaseRow,
                    cv.isSpaceRow {
                    if let pv = previousView as? BaseRow,
                        !pv.isSpaceRow {
                        currentView.addLine(position: .minYEdge, color: self.separatorColor, weight: 1)
                    }
                } else if let pv = previousView as? BaseRow,
                    pv.isSpaceRow {
                    previousView.addLine(position: .maxYEdge, color: self.separatorColor, weight: 1)
                } else {
                    currentView.addLine(position: .minYEdge, color: self.separatorColor, weight: 1)
                }
            }
        }
    }
    
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
            setupRowConstraint(view)
        }
        self.redrawBorder()
    }
}

extension PNPForm: Form {
    
    public func getRows() -> [BaseRow] {
        return self.formRows
    }
    
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
    
    public func getViews() -> [UIView] {
        return self.stackView.arrangedSubviews
    }
    
    public func getViews(withViewClass rowClass: AnyClass) -> [UIView] {
        return self.stackView.arrangedSubviews.filter({ view in
            type(of: view) == rowClass
        })
    }
    
    public func validateRows() -> Bool {
        var result = true
        self.formRows.forEach({
            let isValid = $0.validateRow()
            result = (result && isValid)
        })
        return result
    }
    
    public func prefillRowsInOrder(orderedValues values: [String]) {
        let runs = min(values.count, self.formRows.count)
        for i in 0..<runs {
            self.formRows[i].value = values[i]
        }
    }
    
    public func prefillRows(titleValueMap values: [String: String]) {
        self.formRows.forEach({ row in
            if let label = row.label as? String, let value = values[label] {
                row.value = value
            }
        })
    }
    
    public func prefillRows(iconValueMap values: [UIImage: String]) {
        self.formRows.forEach({ row in
            if let label = row.label as? UIImage, let value = values[label] {
                row.value = value
            }
        })
    }
    
    public func extractRowValuesInOrder() -> [String] {
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
            if let label = row.label as? String,
                list.contains(label) {
                result[label] = row.value
            }
        })
        return result
    }
    
    
    public func extractRowValues(withLabelIconList list: [UIImage]) -> [UIImage : String] {
        var result: [UIImage: String] = [:]
        self.formRows.forEach({ row in
            if let label = row.label as? UIImage,
                list.contains(label) {
                result[label] = row.value
            }
        })
        return result
    }
    
    public func appendView(view: UIView) {
        self.stackView.addArrangedSubview(view)
        self.setupRowConstraint(view)
        self.redrawBorder()
    }
}
