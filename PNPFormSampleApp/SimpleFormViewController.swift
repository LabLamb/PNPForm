//
//  Copyright © LabLambWorks. All rights reserved.
//

import PNPForm
import UIKit

class SimpleFormViewController: PNPFormViewController {
    
    let simpleForm: PNPForm
    let submitButtonForm: PNPForm
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        
        self.simpleForm = {
            let nameConfig = PNPRowConfig(validation: .require)
            let emailConfig = PNPRowConfig(validation: .pattern(.email))
            
            let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
            let passwordConfig = PNPRowConfig(validation: .customPattern(passwordPattern))
            
            let addressConfig = PNPRowConfig(type: .multLineText)
            
            let textFormFields = [
                TextLabelFormRow(title: "Name", config: nameConfig),
                TextLabelFormRow(title: "Email", config: emailConfig),
                TextLabelFormRow(title: "Password", config: passwordConfig),
                TextLabelFormRow(title: "Address", config: addressConfig),
                TextLabelFormRow(title: "Remark")
            ]
            
            return PNPForm(rows: textFormFields, separatorColor: sepColor)
        }()

        let submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.systemBlue, for: .normal)
        
        self.submitButtonForm = {
            return PNPForm(rows: [submitButton], separatorColor: sepColor)
        }()
        
        super.init()
        
        submitButton.addTarget(self, action: #selector(self.submitButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func submitButtonPressed() {
        let validations = self.simpleForm.validateRows()
        for (k, v) in validations {
            print("\(k): \(v)")
        }
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
        
        self.scrollView.addSubview(self.submitButtonForm)
        self.submitButtonForm.translatesAutoresizingMaskIntoConstraints = false
        [
            self.submitButtonForm.topAnchor.constraint(equalTo: self.simpleForm.bottomAnchor, constant: 20),
            self.submitButtonForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.submitButtonForm.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.submitButtonForm.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
            ].forEach({ $0.isActive = true })
        self.submitButtonForm.backgroundColor = .white
    }
}

