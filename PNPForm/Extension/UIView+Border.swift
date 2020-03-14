//
//  Copyright © LabLambWorks. All rights reserved.
//

import UIKit

class UILine: UIView {}

extension UIView {
    func addLine(position: CGRectEdge, color: UIColor, weight: CGFloat) {
        let lineView = UILine()
        lineView.backgroundColor = color
        self.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        switch position {
        case .minXEdge:
            [
                lineView.heightAnchor.constraint(equalTo: self.heightAnchor),
                lineView.widthAnchor.constraint(equalToConstant: weight),
                lineView.centerXAnchor.constraint(equalTo: self.leftAnchor),
                lineView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ].forEach({ $0.isActive = true })
        case .maxXEdge:
            [
                lineView.heightAnchor.constraint(equalTo: self.heightAnchor),
                lineView.widthAnchor.constraint(equalToConstant: weight),
                lineView.centerXAnchor.constraint(equalTo: self.rightAnchor),
                lineView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ].forEach({ $0.isActive = true })
        case .minYEdge:
            [
                lineView.heightAnchor.constraint(equalToConstant: weight),
                lineView.widthAnchor.constraint(equalTo: self.widthAnchor),
                lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                lineView.centerYAnchor.constraint(equalTo: self.topAnchor)
            ].forEach({ $0.isActive = true })
        case .maxYEdge:
            [
                lineView.heightAnchor.constraint(equalToConstant: weight),
                lineView.widthAnchor.constraint(equalTo: self.widthAnchor),
                lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                lineView.centerYAnchor.constraint(equalTo: self.bottomAnchor)
            ].forEach({ $0.isActive = true })
        }
    }
}
