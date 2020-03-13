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
        result.setTitle("Basic Form", for: .normal)
        result.setTitleColor(.systemBlue, for: .normal)
        result.addTarget(self, action: #selector(self.navToBasic), for: .touchUpInside)
        return result
    }()
    
    lazy var navToIconBtn: UIButton = {
        let result = UIButton()
        result.setTitle("Icon Form", for: .normal)
        result.setTitleColor(.systemBlue, for: .normal)
        result.addTarget(self, action: #selector(self.navToIcon), for: .touchUpInside)
        return result
    }()
    
    lazy var stackView: UIStackView = {
        let result = UIStackView()
        result.addArrangedSubview(self.navToBasicBtn)
        result.addArrangedSubview(self.navToPlainBtn)
        result.addArrangedSubview(self.navToIconBtn)
        result.alignment = .center
        result.axis = .vertical
        result.distribution = .equalCentering
        result.spacing = 25
        return result
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Select a sample form"
        
        self.setupLayout()
    }
    
    func setupLayout() {
        self.view.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        [
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ].forEach({ $0.isActive = true })
    }
    
    @objc func navToBasic() {
        self.navigationController?.pushViewController(BasicFormViewController(), animated: true)
    }
    
    @objc func navToPlain() {
        self.navigationController?.pushViewController(PlainFormViewController(), animated: true)
    }
    
    @objc func navToIcon() {
        self.navigationController?.pushViewController(IconFormViewController(), animated: true)
    }
    
}
