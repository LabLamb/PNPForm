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
            NSLayoutConstraint.activate([
                lineView.heightAnchor.constraint(equalTo: self.heightAnchor),
                lineView.widthAnchor.constraint(equalToConstant: weight),
                lineView.centerXAnchor.constraint(equalTo: self.leftAnchor),
                lineView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        case .maxXEdge:
            NSLayoutConstraint.activate([
                lineView.heightAnchor.constraint(equalTo: self.heightAnchor),
                lineView.widthAnchor.constraint(equalToConstant: weight),
                lineView.centerXAnchor.constraint(equalTo: self.rightAnchor),
                lineView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        case .minYEdge:
            NSLayoutConstraint.activate([
                lineView.heightAnchor.constraint(equalToConstant: weight),
                lineView.widthAnchor.constraint(equalTo: self.widthAnchor),
                lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                lineView.centerYAnchor.constraint(equalTo: self.topAnchor)
            ])
        case .maxYEdge:
            NSLayoutConstraint.activate([
                lineView.heightAnchor.constraint(equalToConstant: weight),
                lineView.widthAnchor.constraint(equalTo: self.widthAnchor),
                lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                lineView.centerYAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
    }
}
