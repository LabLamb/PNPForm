//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import UIKit

class PNPCheck: UILabel {
    
    let checkSymbol: String
    
    init(checkSymbol: String,
         checkColor: UIColor) {
        self.checkSymbol = checkSymbol
        super.init(frame: .zero)
        self.text = checkSymbol
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.toggleCheckSymbol))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGest)
        
        self.textAlignment = .right
        self.textColor = checkColor
        self.font = UIFont.systemFont(ofSize: self.font.pointSize + 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleCheckSymbol() {
        if self.text == "" {
            self.text = self.checkSymbol
        } else {
            self.text = ""
        }
    }
    
}
