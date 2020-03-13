//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import UIKit
class SelectionViewController: UIViewController {
    
    lazy var navToPlainBtn: UIButton = {
        let result = UIButton()
        result.setTitle("Plain Form", for: .normal)
        result.setTitleColor(.systemBlue, for: .normal)
        result.addTarget(self, action: #selector(self.navToPlain), for: .touchUpInside)
        return result
    }()
    
    lazy var navToBasicBtn: UIButton = {
        let result = UIButton()
        result.setTitle("Plain Form", for: .normal)
        result.setTitleColor(.systemBlue, for: .normal)
        return result
    }()
    
    lazy var navToIconBtn: UIButton = {
        let result = UIButton()
        result.setTitle("Plain Form", for: .normal)
        result.setTitleColor(.systemBlue, for: .normal)
        return result
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Select a sample form"
        
        self.setupLayout()
    }
    
    func setupLayout() {
        self.view.addSubview(navToPlainBtn)
        self.navToPlainBtn.translatesAutoresizingMaskIntoConstraints = false
        [
            self.navToPlainBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.navToPlainBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ].forEach({ $0.isActive = true })
    }
    
    @objc func navToPlain() {
        self.navigationController?.pushViewController(PlainFormViewController(), animated: true)
    }
    
}
