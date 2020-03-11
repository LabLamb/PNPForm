//
//  Copyright © LabLambWorks. All rights reserved.
//

import PNPForm
import UIKit

class SimpleFormViewController: PNPFormViewController {
    
    let simpleForm: PNPForm
    let submitButton: PNPForm
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        
        self.simpleForm = {
            let passwordField: UITextField = {
                let result = UITextField()
                result.isSecureTextEntry = true
                return result
            }()
            
            let textFormFields = [
                TextLabelFormRow(title: "Email", with: UITextField(), spacing: 10),
                TextLabelFormRow(title: "Password", with: passwordField, spacing: 10)
            ]
            
            return PNPForm(rows: textFormFields, separatorColor: sepColor)
        }()
        
        self.submitButton = {
            let btn = UIButton()
            btn.setTitle("Submit", for: .normal)
            btn.setTitleColor(.systemBlue, for: .normal)
            
            return PNPForm(rows: [btn], separatorColor: sepColor)
        }()
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        
        
        super.setupLayout()
        self.scrollView.addSubview(self.simpleForm)
        self.simpleForm.translatesAutoresizingMaskIntoConstraints = false
        [
            self.simpleForm.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.simpleForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.simpleForm.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ].forEach({ $0.isActive = true })
        self.simpleForm.backgroundColor = .white
        
        self.scrollView.addSubview(self.submitButton)
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        [
            self.submitButton.topAnchor.constraint(equalTo: self.simpleForm.bottomAnchor, constant: 20),
            self.submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.submitButton.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
            ].forEach({ $0.isActive = true })
        self.submitButton.backgroundColor = .white
    }
}

